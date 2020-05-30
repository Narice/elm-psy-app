module Main exposing (..)

import Api.InputObject exposing (..)
import Api.Mutation as Mutation exposing (..)
import Api.Object exposing (..)
import Api.Object.Profession
import Api.Object.Profession_mutation_response
import Api.Query as Query exposing (..)
import Api.Scalar exposing (..)
import Api.ScalarCodecs
import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Graphql.Http exposing (HttpError(..))
import Graphql.Http.GraphqlError
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Html exposing (Html)
import Http
import Json.Decode exposing (Decoder, field, string)
import RemoteData exposing (RemoteData(..))



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type Model
    = Model RawModel


type alias RawModel =
    { getProfessionData : GetProfessionData
    , addProfessionData : AddProfessionData
    , form : Form
    }


type alias Form =
    { profession : String
    }


emptyForm : Form
emptyForm =
    { profession = ""
    }


updateForm : (Form -> Form) -> RawModel -> ( Model, Cmd Msg )
updateForm transform data =
    ( Model { data | form = transform data.form }, Cmd.none )


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        { getProfessionData = Loading
        , addProfessionData = NotAsked
        , form = emptyForm
        }
    , getProfessionRequest
    )



-- UPDATE


type Msg
    = GetProfessionResponse GetProfessionData
    | AddProfessionResponse AddProfessionData
    | AddProfession
      -- Form Inputs
    | EnteredDate String



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        data =
            case model of
                Model datamodel ->
                    datamodel
    in
    case msg of
        GetProfessionResponse getProfessionData ->
            case getProfessionData of
                NotAsked ->
                    ( model, Cmd.none )

                Loading ->
                    ( model, Cmd.none )

                Success response ->
                    ( Model { data | getProfessionData = getProfessionData }, Cmd.none )

                Failure error ->
                    ( Model { data | getProfessionData = getProfessionData }, Cmd.none )

        AddProfessionResponse addProfessionData ->
            case addProfessionData of
                NotAsked ->
                    ( model, Cmd.none )

                Loading ->
                    ( model, Cmd.none )

                Success response ->
                    ( Model { data | addProfessionData = addProfessionData }, Cmd.none )

                Failure error ->
                    ( Model { data | addProfessionData = addProfessionData }, Cmd.none )

        AddProfession ->
            ( model, addProfessionRequest data.form )

        EnteredDate text ->
            updateForm (\form -> { form | profession = text }) data



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        data =
            case model of
                Model datamodel ->
                    datamodel
    in
    case data.getProfessionData of
        NotAsked ->
            layout [] <|
                el [ centerX, centerY ]
                    (text "The request was not made :/")

        Loading ->
            layout [] <|
                el [ centerX, centerY ]
                    (text "A proper expression")

        Success response ->
            successView response data.form

        Failure error ->
            failureView error


successView : List Profession -> Form -> Html Msg
successView response form =
    layout [] <|
        column [ centerX, centerY, Background.color (rgb255 214 217 216), height fill, width fill]
            [ row[ centerX,padding 50]
                [image [ width (fill |> maximum 80)] {src ="logo.png", description = "logo"}
                ,el [ Font.color (rgb255 111 144 166), Font.size (80)] (text "Votre liste de professions")
                ,image [ width (fill |> maximum 80)] {src ="logo.png", description = "logo"}
                ]
            , professionTable response
            , row [ centerX, padding 30 ]
                [ textInput EnteredDate form.profession "Profession" "Profession"
                ]
            , Input.button [ centerX, centerY ]
                { label =
                    el [ padding 30,  Border.rounded 5, Background.color (rgb255 111 144 166) 
                        ,mouseOver [Background.color (rgb255 140 179 196)],
                        Element.focused [ Background.color (rgb255 24 52 61), Font.color(rgb255 214 217 216)]]
                        (text "Ajouter une profession")
                , onPress = Just AddProfession
                }
            ]


textInput : (String -> Msg) -> String -> String -> String -> Element Msg
textInput msg formtext placeholder label =
    Input.text []
        { onChange = msg
        , text = formtext
        , placeholder = Just (Input.placeholder [] (text placeholder))
        , label = Input.labelAbove [] (text label)
        }


professionTable : List Profession -> Element Msg
professionTable response =
    table [ centerX, centerY, padding 30, Background.color (rgb255  111 144 166)] 
        { data = response
        , columns =
            [ { header = tableField "Profession"
              , width = fill
              , view = \profession -> tableField profession.profession
              }
            ]
        }


tableField : String -> Element Msg
tableField data =
    el [ centerX, centerY, padding 23, Border.width 1, Background.color (rgb255 140 179 196) 
    ,Border.color(rgb255 24 52 61) ] (text data)


failureView : Graphql.Http.Error parsedData -> Html Msg
failureView error =
    layout [] <|
        el [ centerX, centerY ]
            (error
                |> errorToString
                |> text
            )


errorToString : Graphql.Http.Error parsedData -> String
errorToString errorData =
    case errorData of
        Graphql.Http.GraphqlError _ graphqlErrors ->
            graphqlErrors
                |> List.map graphqlErrorToString
                |> String.join "\n"

        Graphql.Http.HttpError httpError ->
            case httpError of
                BadUrl error ->
                    error

                Timeout ->
                    "There was a timeout"

                NetworkError ->
                    "There was a network error"

                BadStatus metadata error ->
                    error

                BadPayload jsonDecodeError ->
                    "There was a bad payload"


graphqlErrorToString : Graphql.Http.GraphqlError.GraphqlError -> String
graphqlErrorToString error =
    error.message



-- GRAPHQL


type alias Profession =
    { profession : String
    }


type alias GetProfessionData =
    RemoteData (Graphql.Http.Error (List Profession)) (List Profession)


getProfession : SelectionSet Profession Api.Object.Profession
getProfession =
    -- Profession is the type alias and thus the constructor of a record
    -- it will thus take all of these parameters as input
    SelectionSet.succeed Profession
        |> with Api.Object.Profession.profession


getProfessionQuery : SelectionSet (List Profession) RootQuery
getProfessionQuery =
    Query.profession identity getProfession


getProfessionRequest : Cmd Msg
getProfessionRequest =
    getProfessionQuery
        |> Graphql.Http.queryRequest "https://bdd-psy-app.herokuapp.com/v1/graphql"
        |> Graphql.Http.withHeader "x-hasura-admin-secret" "Dq4LwJ7PzeKTo4XYa6CoaqoQbPXtTZ9qEMHmgC46m78jTdVJvU"
        |> Graphql.Http.send (RemoteData.fromResult >> GetProfessionResponse)


type alias AddProfessionData =
    RemoteData (Graphql.Http.Error (Maybe (List Profession))) (Maybe (List Profession))


getProfessionMutation : SelectionSet (List Profession) Api.Object.Profession_mutation_response
getProfessionMutation =
    Api.Object.Profession_mutation_response.returning getProfession


addProfession : Form -> SelectionSet (Maybe (List Profession)) RootMutation
addProfession form =
    let
        professioninsert =
            { patient_Professions = Absent
            , profession = Present form.profession
            , id_profession = Absent
            }

        reqArgs : InsertProfessionRequiredArguments
        reqArgs =
            InsertProfessionRequiredArguments
                [ Profession_insert_input professioninsert ]
    in
    Mutation.insert_Profession (\optionals -> optionals)
        reqArgs
        getProfessionMutation



-- Profession is the type alias and thus the constructor of a record
-- it will thus take all of these parameters as input


addProfessionRequest : Form -> Cmd Msg
addProfessionRequest form =
    addProfession form
        |> Graphql.Http.mutationRequest "https://bdd-psy-app.herokuapp.com/v1/graphql"
        |> Graphql.Http.withHeader "x-hasura-admin-secret" "Dq4LwJ7PzeKTo4XYa6CoaqoQbPXtTZ9qEMHmgC46m78jTdVJvU"
        |> Graphql.Http.send (RemoteData.fromResult >> AddProfessionResponse)