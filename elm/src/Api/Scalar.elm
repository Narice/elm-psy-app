-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Scalar exposing (Codecs, Date(..), Id(..), Money(..), Smallint(..), Timetz(..), defaultCodecs, defineCodecs, unwrapCodecs, unwrapEncoder)

import Graphql.Codec exposing (Codec)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


type Date
    = Date String


type Id
    = Id String


type Money
    = Money String


type Smallint
    = Smallint String


type Timetz
    = Timetz String


defineCodecs :
    { codecDate : Codec valueDate
    , codecId : Codec valueId
    , codecMoney : Codec valueMoney
    , codecSmallint : Codec valueSmallint
    , codecTimetz : Codec valueTimetz
    }
    -> Codecs valueDate valueId valueMoney valueSmallint valueTimetz
defineCodecs definitions =
    Codecs definitions


unwrapCodecs :
    Codecs valueDate valueId valueMoney valueSmallint valueTimetz
    ->
        { codecDate : Codec valueDate
        , codecId : Codec valueId
        , codecMoney : Codec valueMoney
        , codecSmallint : Codec valueSmallint
        , codecTimetz : Codec valueTimetz
        }
unwrapCodecs (Codecs unwrappedCodecs) =
    unwrappedCodecs


unwrapEncoder getter (Codecs unwrappedCodecs) =
    (unwrappedCodecs |> getter |> .encoder) >> Graphql.Internal.Encode.fromJson


type Codecs valueDate valueId valueMoney valueSmallint valueTimetz
    = Codecs (RawCodecs valueDate valueId valueMoney valueSmallint valueTimetz)


type alias RawCodecs valueDate valueId valueMoney valueSmallint valueTimetz =
    { codecDate : Codec valueDate
    , codecId : Codec valueId
    , codecMoney : Codec valueMoney
    , codecSmallint : Codec valueSmallint
    , codecTimetz : Codec valueTimetz
    }


defaultCodecs : RawCodecs Date Id Money Smallint Timetz
defaultCodecs =
    { codecDate =
        { encoder = \(Date raw) -> Encode.string raw
        , decoder = Object.scalarDecoder |> Decode.map Date
        }
    , codecId =
        { encoder = \(Id raw) -> Encode.string raw
        , decoder = Object.scalarDecoder |> Decode.map Id
        }
    , codecMoney =
        { encoder = \(Money raw) -> Encode.string raw
        , decoder = Object.scalarDecoder |> Decode.map Money
        }
    , codecSmallint =
        { encoder = \(Smallint raw) -> Encode.string raw
        , decoder = Object.scalarDecoder |> Decode.map Smallint
        }
    , codecTimetz =
        { encoder = \(Timetz raw) -> Encode.string raw
        , decoder = Object.scalarDecoder |> Decode.map Timetz
        }
    }
