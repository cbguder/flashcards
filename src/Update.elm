module Update exposing (..)

import Commands exposing (shuffleQuestions)
import Model exposing (Model(..))
import Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotQuestions result ->
            case result of
                Ok questions ->
                    ( Loading, shuffleQuestions questions )

                Err _ ->
                    ( Failure, Cmd.none )

        ShuffledQuestions questions ->
            ( Success { questions = questions, index = 0 }
            , Cmd.none
            )

        NextQuestion ->
            case model of
                Success m ->
                    ( nextQuestion m, Cmd.none )

                other ->
                    ( other, Cmd.none )

        PreviousQuestion ->
            case model of
                Success m ->
                    ( previousQuestion m, Cmd.none )

                other ->
                    ( other, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


previousQuestion m =
    if m.index > 0 then
        Success { m | index = m.index - 1 }

    else
        Success m


nextQuestion m =
    if List.length m.questions > m.index then
        Success { m | index = m.index + 1 }

    else
        Done m
