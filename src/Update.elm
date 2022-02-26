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
            ( Question { questions = questions, index = 0 }
            , Cmd.none
            )

        NextQuestion ->
            case model of
                Question m ->
                    ( Answer m, Cmd.none )

                Answer m ->
                    ( nextQuestion m, Cmd.none )

                Done m ->
                    ( Loading, shuffleQuestions m.questions )

                other ->
                    ( other, Cmd.none )

        PreviousQuestion ->
            case model of
                Question m ->
                    ( previousQuestion m, Cmd.none )

                Answer m ->
                    ( Question m, Cmd.none )

                Done m ->
                    ( Question m, Cmd.none )

                other ->
                    ( other, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


previousQuestion m =
    if m.index > 0 then
        Question { m | index = m.index - 1 }

    else
        Question m


nextQuestion m =
    if List.length m.questions > m.index + 1 then
        Question { m | index = m.index + 1 }

    else
        Done m
