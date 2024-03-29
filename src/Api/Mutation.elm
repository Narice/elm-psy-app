-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Mutation exposing (..)

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
import Json.Decode as Decode exposing (Decoder)


type alias DeleteAgendaRequiredArguments =
    { where_ : Api.InputObject.Agenda_bool_exp }


{-| delete data from the table: "Agenda"

  - where\_ - filter the rows which have to be deleted

-}
delete_Agenda : DeleteAgendaRequiredArguments -> SelectionSet decodesTo Api.Object.Agenda_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
delete_Agenda requiredArgs object_ =
    Object.selectionForCompositeField "delete_Agenda" [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodeAgenda_bool_exp ] object_ (identity >> Decode.nullable)


type alias DeleteConsultationRequiredArguments =
    { where_ : Api.InputObject.Consultation_bool_exp }


{-| delete data from the table: "Consultation"

  - where\_ - filter the rows which have to be deleted

-}
delete_Consultation : DeleteConsultationRequiredArguments -> SelectionSet decodesTo Api.Object.Consultation_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
delete_Consultation requiredArgs object_ =
    Object.selectionForCompositeField "delete_Consultation" [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodeConsultation_bool_exp ] object_ (identity >> Decode.nullable)


type alias DeletePatientRequiredArguments =
    { where_ : Api.InputObject.Patient_bool_exp }


{-| delete data from the table: "Patient"

  - where\_ - filter the rows which have to be deleted

-}
delete_Patient : DeletePatientRequiredArguments -> SelectionSet decodesTo Api.Object.Patient_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
delete_Patient requiredArgs object_ =
    Object.selectionForCompositeField "delete_Patient" [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodePatient_bool_exp ] object_ (identity >> Decode.nullable)


type alias DeletePatientProfessionRequiredArguments =
    { where_ : Api.InputObject.Patient_Profession_bool_exp }


{-| delete data from the table: "Patient\_Profession"

  - where\_ - filter the rows which have to be deleted

-}
delete_Patient_Profession : DeletePatientProfessionRequiredArguments -> SelectionSet decodesTo Api.Object.Patient_Profession_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
delete_Patient_Profession requiredArgs object_ =
    Object.selectionForCompositeField "delete_Patient_Profession" [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodePatient_Profession_bool_exp ] object_ (identity >> Decode.nullable)


type alias DeleteProfessionRequiredArguments =
    { where_ : Api.InputObject.Profession_bool_exp }


{-| delete data from the table: "Profession"

  - where\_ - filter the rows which have to be deleted

-}
delete_Profession : DeleteProfessionRequiredArguments -> SelectionSet decodesTo Api.Object.Profession_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
delete_Profession requiredArgs object_ =
    Object.selectionForCompositeField "delete_Profession" [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodeProfession_bool_exp ] object_ (identity >> Decode.nullable)


type alias InsertAgendaOptionalArguments =
    { on_conflict : OptionalArgument Api.InputObject.Agenda_on_conflict }


type alias InsertAgendaRequiredArguments =
    { objects : List Api.InputObject.Agenda_insert_input }


{-| insert data into the table: "Agenda"

  - objects - the rows to be inserted
  - on\_conflict - on conflict condition

-}
insert_Agenda : (InsertAgendaOptionalArguments -> InsertAgendaOptionalArguments) -> InsertAgendaRequiredArguments -> SelectionSet decodesTo Api.Object.Agenda_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
insert_Agenda fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { on_conflict = Absent }

        optionalArgs =
            [ Argument.optional "on_conflict" filledInOptionals.on_conflict Api.InputObject.encodeAgenda_on_conflict ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "insert_Agenda" (optionalArgs ++ [ Argument.required "objects" requiredArgs.objects (Api.InputObject.encodeAgenda_insert_input |> Encode.list) ]) object_ (identity >> Decode.nullable)


type alias InsertConsultationOptionalArguments =
    { on_conflict : OptionalArgument Api.InputObject.Consultation_on_conflict }


type alias InsertConsultationRequiredArguments =
    { objects : List Api.InputObject.Consultation_insert_input }


{-| insert data into the table: "Consultation"

  - objects - the rows to be inserted
  - on\_conflict - on conflict condition

-}
insert_Consultation : (InsertConsultationOptionalArguments -> InsertConsultationOptionalArguments) -> InsertConsultationRequiredArguments -> SelectionSet decodesTo Api.Object.Consultation_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
insert_Consultation fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { on_conflict = Absent }

        optionalArgs =
            [ Argument.optional "on_conflict" filledInOptionals.on_conflict Api.InputObject.encodeConsultation_on_conflict ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "insert_Consultation" (optionalArgs ++ [ Argument.required "objects" requiredArgs.objects (Api.InputObject.encodeConsultation_insert_input |> Encode.list) ]) object_ (identity >> Decode.nullable)


type alias InsertPatientOptionalArguments =
    { on_conflict : OptionalArgument Api.InputObject.Patient_on_conflict }


type alias InsertPatientRequiredArguments =
    { objects : List Api.InputObject.Patient_insert_input }


{-| insert data into the table: "Patient"

  - objects - the rows to be inserted
  - on\_conflict - on conflict condition

-}
insert_Patient : (InsertPatientOptionalArguments -> InsertPatientOptionalArguments) -> InsertPatientRequiredArguments -> SelectionSet decodesTo Api.Object.Patient_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
insert_Patient fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { on_conflict = Absent }

        optionalArgs =
            [ Argument.optional "on_conflict" filledInOptionals.on_conflict Api.InputObject.encodePatient_on_conflict ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "insert_Patient" (optionalArgs ++ [ Argument.required "objects" requiredArgs.objects (Api.InputObject.encodePatient_insert_input |> Encode.list) ]) object_ (identity >> Decode.nullable)


type alias InsertPatientProfessionOptionalArguments =
    { on_conflict : OptionalArgument Api.InputObject.Patient_Profession_on_conflict }


type alias InsertPatientProfessionRequiredArguments =
    { objects : List Api.InputObject.Patient_Profession_insert_input }


{-| insert data into the table: "Patient\_Profession"

  - objects - the rows to be inserted
  - on\_conflict - on conflict condition

-}
insert_Patient_Profession : (InsertPatientProfessionOptionalArguments -> InsertPatientProfessionOptionalArguments) -> InsertPatientProfessionRequiredArguments -> SelectionSet decodesTo Api.Object.Patient_Profession_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
insert_Patient_Profession fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { on_conflict = Absent }

        optionalArgs =
            [ Argument.optional "on_conflict" filledInOptionals.on_conflict Api.InputObject.encodePatient_Profession_on_conflict ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "insert_Patient_Profession" (optionalArgs ++ [ Argument.required "objects" requiredArgs.objects (Api.InputObject.encodePatient_Profession_insert_input |> Encode.list) ]) object_ (identity >> Decode.nullable)


type alias InsertProfessionOptionalArguments =
    { on_conflict : OptionalArgument Api.InputObject.Profession_on_conflict }


type alias InsertProfessionRequiredArguments =
    { objects : List Api.InputObject.Profession_insert_input }


{-| insert data into the table: "Profession"

  - objects - the rows to be inserted
  - on\_conflict - on conflict condition

-}
insert_Profession : (InsertProfessionOptionalArguments -> InsertProfessionOptionalArguments) -> InsertProfessionRequiredArguments -> SelectionSet decodesTo Api.Object.Profession_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
insert_Profession fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { on_conflict = Absent }

        optionalArgs =
            [ Argument.optional "on_conflict" filledInOptionals.on_conflict Api.InputObject.encodeProfession_on_conflict ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "insert_Profession" (optionalArgs ++ [ Argument.required "objects" requiredArgs.objects (Api.InputObject.encodeProfession_insert_input |> Encode.list) ]) object_ (identity >> Decode.nullable)


type alias UpdateAgendaOptionalArguments =
    { inc_ : OptionalArgument Api.InputObject.Agenda_inc_input
    , set_ : OptionalArgument Api.InputObject.Agenda_set_input
    }


type alias UpdateAgendaRequiredArguments =
    { where_ : Api.InputObject.Agenda_bool_exp }


{-| update data of the table: "Agenda"

  - inc\_ - increments the integer columns with given value of the filtered values
  - set\_ - sets the columns of the filtered rows to the given values
  - where\_ - filter the rows which have to be updated

-}
update_Agenda : (UpdateAgendaOptionalArguments -> UpdateAgendaOptionalArguments) -> UpdateAgendaRequiredArguments -> SelectionSet decodesTo Api.Object.Agenda_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
update_Agenda fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { inc_ = Absent, set_ = Absent }

        optionalArgs =
            [ Argument.optional "_inc" filledInOptionals.inc_ Api.InputObject.encodeAgenda_inc_input, Argument.optional "_set" filledInOptionals.set_ Api.InputObject.encodeAgenda_set_input ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "update_Agenda" (optionalArgs ++ [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodeAgenda_bool_exp ]) object_ (identity >> Decode.nullable)


type alias UpdateConsultationOptionalArguments =
    { inc_ : OptionalArgument Api.InputObject.Consultation_inc_input
    , set_ : OptionalArgument Api.InputObject.Consultation_set_input
    }


type alias UpdateConsultationRequiredArguments =
    { where_ : Api.InputObject.Consultation_bool_exp }


{-| update data of the table: "Consultation"

  - inc\_ - increments the integer columns with given value of the filtered values
  - set\_ - sets the columns of the filtered rows to the given values
  - where\_ - filter the rows which have to be updated

-}
update_Consultation : (UpdateConsultationOptionalArguments -> UpdateConsultationOptionalArguments) -> UpdateConsultationRequiredArguments -> SelectionSet decodesTo Api.Object.Consultation_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
update_Consultation fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { inc_ = Absent, set_ = Absent }

        optionalArgs =
            [ Argument.optional "_inc" filledInOptionals.inc_ Api.InputObject.encodeConsultation_inc_input, Argument.optional "_set" filledInOptionals.set_ Api.InputObject.encodeConsultation_set_input ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "update_Consultation" (optionalArgs ++ [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodeConsultation_bool_exp ]) object_ (identity >> Decode.nullable)


type alias UpdatePatientOptionalArguments =
    { inc_ : OptionalArgument Api.InputObject.Patient_inc_input
    , set_ : OptionalArgument Api.InputObject.Patient_set_input
    }


type alias UpdatePatientRequiredArguments =
    { where_ : Api.InputObject.Patient_bool_exp }


{-| update data of the table: "Patient"

  - inc\_ - increments the integer columns with given value of the filtered values
  - set\_ - sets the columns of the filtered rows to the given values
  - where\_ - filter the rows which have to be updated

-}
update_Patient : (UpdatePatientOptionalArguments -> UpdatePatientOptionalArguments) -> UpdatePatientRequiredArguments -> SelectionSet decodesTo Api.Object.Patient_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
update_Patient fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { inc_ = Absent, set_ = Absent }

        optionalArgs =
            [ Argument.optional "_inc" filledInOptionals.inc_ Api.InputObject.encodePatient_inc_input, Argument.optional "_set" filledInOptionals.set_ Api.InputObject.encodePatient_set_input ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "update_Patient" (optionalArgs ++ [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodePatient_bool_exp ]) object_ (identity >> Decode.nullable)


type alias UpdatePatientProfessionOptionalArguments =
    { inc_ : OptionalArgument Api.InputObject.Patient_Profession_inc_input
    , set_ : OptionalArgument Api.InputObject.Patient_Profession_set_input
    }


type alias UpdatePatientProfessionRequiredArguments =
    { where_ : Api.InputObject.Patient_Profession_bool_exp }


{-| update data of the table: "Patient\_Profession"

  - inc\_ - increments the integer columns with given value of the filtered values
  - set\_ - sets the columns of the filtered rows to the given values
  - where\_ - filter the rows which have to be updated

-}
update_Patient_Profession : (UpdatePatientProfessionOptionalArguments -> UpdatePatientProfessionOptionalArguments) -> UpdatePatientProfessionRequiredArguments -> SelectionSet decodesTo Api.Object.Patient_Profession_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
update_Patient_Profession fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { inc_ = Absent, set_ = Absent }

        optionalArgs =
            [ Argument.optional "_inc" filledInOptionals.inc_ Api.InputObject.encodePatient_Profession_inc_input, Argument.optional "_set" filledInOptionals.set_ Api.InputObject.encodePatient_Profession_set_input ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "update_Patient_Profession" (optionalArgs ++ [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodePatient_Profession_bool_exp ]) object_ (identity >> Decode.nullable)


type alias UpdateProfessionOptionalArguments =
    { inc_ : OptionalArgument Api.InputObject.Profession_inc_input
    , set_ : OptionalArgument Api.InputObject.Profession_set_input
    }


type alias UpdateProfessionRequiredArguments =
    { where_ : Api.InputObject.Profession_bool_exp }


{-| update data of the table: "Profession"

  - inc\_ - increments the integer columns with given value of the filtered values
  - set\_ - sets the columns of the filtered rows to the given values
  - where\_ - filter the rows which have to be updated

-}
update_Profession : (UpdateProfessionOptionalArguments -> UpdateProfessionOptionalArguments) -> UpdateProfessionRequiredArguments -> SelectionSet decodesTo Api.Object.Profession_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
update_Profession fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { inc_ = Absent, set_ = Absent }

        optionalArgs =
            [ Argument.optional "_inc" filledInOptionals.inc_ Api.InputObject.encodeProfession_inc_input, Argument.optional "_set" filledInOptionals.set_ Api.InputObject.encodeProfession_set_input ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "update_Profession" (optionalArgs ++ [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodeProfession_bool_exp ]) object_ (identity >> Decode.nullable)
