module Subscriptions exposing (..)

import Browser.Events as Events
import Json.Decode exposing (Decoder, field, map, string)
import Model exposing (Model(..))
import Msg exposing (Msg(..))


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        Success _ ->
            Events.onKeyDown keyDecoder

        _ ->
            Sub.none


keyDecoder =
    map toKey (field "key" string)


toKey : String -> Msg
toKey key =
    case key of
        "ArrowLeft" ->
            PreviousQuestion

        "ArrowRight" ->
            NextQuestion

        _ ->
            NoOp
