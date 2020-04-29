-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Object.Patient_mutation_response exposing (..)

import Api.InputObject
import Api.Interface
import Api.Object
import Api.Scalar
import Api.ScalarCodecs
import Api.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| number of affected rows by the mutation
-}
affected_rows : SelectionSet Int Api.Object.Patient_mutation_response
affected_rows =
    Object.selectionForField "Int" "affected_rows" [] Decode.int


{-| data of the affected rows by the mutation
-}
returning : SelectionSet decodesTo Api.Object.Patient -> SelectionSet (List decodesTo) Api.Object.Patient_mutation_response
returning object_ =
    Object.selectionForCompositeField "returning" [] object_ (identity >> Decode.list)
