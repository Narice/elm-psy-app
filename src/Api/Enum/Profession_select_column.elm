-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Enum.Profession_select_column exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| select columns of table "Profession"

  - Id\_profession - column name
  - Profession - column name

-}
type Profession_select_column
    = Id_profession
    | Profession


list : List Profession_select_column
list =
    [ Id_profession, Profession ]


decoder : Decoder Profession_select_column
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "id_profession" ->
                        Decode.succeed Id_profession

                    "profession" ->
                        Decode.succeed Profession

                    _ ->
                        Decode.fail ("Invalid Profession_select_column type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : Profession_select_column -> String
toString enum =
    case enum of
        Id_profession ->
            "id_profession"

        Profession ->
            "profession"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe Profession_select_column
fromString enumString =
    case enumString of
        "id_profession" ->
            Just Id_profession

        "profession" ->
            Just Profession

        _ ->
            Nothing
