port module Api exposing (Cred, Role(..), application, checkTokenExpiry, credChanges, credHeader, getRoleFromMaybeCred, isExpired, logout, makeMutation, makeQuery, storeCred, storeCredFromAuth)

import Api.InputObject exposing (..)
import Api.Mutation as Mutation exposing (..)
import Api.Object exposing (..)
import Api.Object.Patient
import Api.Object.Patient_mutation_response
import Api.Query as Query exposing (..)
import Api.Scalar exposing (..)
import Api.ScalarCodecs
import Auth0.UrlParser exposing (Auth0CallbackInfo)
import Browser
import Browser.Navigation as Nav
import Graphql.Http exposing (Request)
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)
import Http exposing (Body, Expect)
import Json.Decode as Decode exposing (Decoder, Value, decodeString, field, string)
import Json.Decode.Pipeline as Pipeline exposing (optional, required)
import Json.Encode as Encode
import Jwt exposing (JwtError)
import RemoteData exposing (RemoteData)
import Task exposing (Task)
import Time exposing (Posix)
import Url exposing (Url)



-- CRED


{-| The authentication credentials for the Viewer (that is, the currently logged-in user.)
This includes:

  - The cred's Username
  - The cred's authentication token
    By design, there is no way to access the token directly as a String.
    It can be encoded for persistence, and it can be added to a header
    to a HttpBuilder for a request, but that's it.
    This token should never be rendered to the end user, and with this API, it
    can't be!

-}
type Cred
    = Cred String --String is the idToken


credHeader :
    Maybe Cred
    -> Request decodesTo
    -> Request decodesTo -- Returns a function for pipeline syntax
credHeader maybeCred =
    case maybeCred of
        Just (Cred str) ->
            Graphql.Http.withHeader "Authorization" ("Bearer " ++ str)

        Nothing ->
            identity


credDecoder : Decoder Cred
credDecoder =
    Decode.succeed Cred
        |> required "token" Decode.string


storeCredFromAuth : Auth0CallbackInfo -> Cmd msg
storeCredFromAuth info =
    case info.idToken of
        Just idToken ->
            storeCred (Cred idToken)

        Nothing ->
            Cmd.none



-- PERSISTENCE


port onStoreChange : (Value -> msg) -> Sub msg


credChanges : (Maybe Cred -> msg) -> Sub msg
credChanges toMsg =
    onStoreChange (\value -> toMsg (decodeFromChange value))


decodeFromChange : Value -> Maybe Cred
decodeFromChange val =
    Decode.decodeValue credDecoder val
        |> Result.toMaybe


storeCred : Cred -> Cmd msg
storeCred (Cred token) =
    let
        json =
            Encode.object
                [ ( "token", Encode.string token ) ]
    in
    storeCache (Just json)


logout : Cmd msg
logout =
    storeCache Nothing


port storeCache : Maybe Value -> Cmd msg



-- SERIALIZATION
-- APPLICATION


application :
    { init : Maybe Cred -> Url -> Nav.Key -> ( model, Cmd msg )
    , onUrlChange : Url -> msg
    , onUrlRequest : Browser.UrlRequest -> msg
    , subscriptions : model -> Sub msg
    , update : msg -> model -> ( model, Cmd msg )
    , view : model -> Browser.Document msg
    }
    -> Program Value model msg
application config =
    let
        init flags url navKey =
            let
                maybeCred =
                    Decode.decodeValue Decode.string flags
                        |> Result.andThen (Decode.decodeString credDecoder)
                        |> Result.toMaybe
            in
            config.init maybeCred url navKey
    in
    Browser.application
        { init = init
        , onUrlChange = config.onUrlChange
        , onUrlRequest = config.onUrlRequest
        , subscriptions = config.subscriptions
        , update = config.update
        , view = config.view
        }



-- Token


type Role
    = Psy
    | User
    | None


getRoleFromMaybeCred : Maybe Cred -> Role
getRoleFromMaybeCred maybecred =
    case maybecred of
        Just (Cred token) ->
            Jwt.decodeToken getRole token |> Result.withDefault None

        Nothing ->
            None


getRole : Decoder Role
getRole =
    Decode.at [ "https://hasura.io/jwt/claims", "x-hasura-default-role" ] Decode.string
        |> Decode.map
            (\string ->
                if string == "Psy" then
                    Psy

                else if string == "user" then
                    User

                else
                    None
            )


checkTokenExpiry : Maybe Cred -> Task Never JwtError
checkTokenExpiry cred =
    let
        tokenval =
            case cred of
                Just (Cred token) ->
                    token

                Nothing ->
                    ""
    in
    Jwt.checkTokenExpiry tokenval


isExpired : Posix -> Maybe Cred -> Result JwtError Bool
isExpired time cred =
    let
        tokenval =
            case cred of
                Just (Cred token) ->
                    token

                Nothing ->
                    ""
    in
    Jwt.isExpired time tokenval



-- Graphql


makeQuery : SelectionSet decodesTo RootQuery -> (RemoteData (Graphql.Http.Error decodesTo) decodesTo -> msg) -> Maybe Cred -> Cmd msg
makeQuery selectionSet msg cred =
    selectionSet
        |> Graphql.Http.queryRequest "https://bdd-psy-app.herokuapp.com/v1/graphql"
        |> credHeader cred
        |> Graphql.Http.send (RemoteData.fromResult >> msg)


makeMutation : SelectionSet decodesTo RootMutation -> (RemoteData (Graphql.Http.Error decodesTo) decodesTo -> msg) -> Maybe Cred -> Cmd msg
makeMutation selectionSet msg cred =
    selectionSet
        |> Graphql.Http.mutationRequest "https://bdd-psy-app.herokuapp.com/v1/graphql"
        |> credHeader cred
        |> Graphql.Http.send (RemoteData.fromResult >> msg)
