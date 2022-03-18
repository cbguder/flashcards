module View exposing (..)

import Array
import Html exposing (Html, div, li, p, span, text, ul)
import Html.Attributes exposing (class, hidden)
import Html.Events exposing (onClick)
import Model exposing (Model(..))
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    case model of
        Loading ->
            emojiView "⏳" "Loading questions..."

        Failure ->
            emojiView "😔" "Failed to load questions"

        Done _ ->
            emojiView "🥳" "Click to restart"

        Question loadedModel ->
            questionView False loadedModel

        Answer loadedModel ->
            questionView True loadedModel


emojiView emoji footnote =
    inContainer
        [ div [ class "emoji" ] [ text emoji ] ]
        [ p [] [ text footnote ] ]


inContainer mainChildren footnoteChildren =
    div
        [ class "container vh-100 user-select-none"
        , onClick NextQuestion
        ]
        [ div
            [ class "main" ]
            mainChildren
        , div
            [ class "footnote text-muted" ]
            footnoteChildren
        ]


questionView showAnswer model =
    let
        question =
            Array.get model.index model.questions
                |> Maybe.withDefault { question = "", answer = Nothing, answers = Nothing }

        pos =
            String.fromInt (model.index + 1)
                ++ " of "
                ++ String.fromInt (Array.length model.questions)

        footnote =
            if showAnswer then
                "Click to go to the next question"

            else
                "Click to show answer"
    in
    inContainer
        [ div [ class "question" ]
            [ text question.question ]
        , div [ class "answer text-secondary", hidden (not showAnswer) ]
            [ formatAnswer question ]
        ]
        [ p [] [ text pos ]
        , p [] [ text footnote ]
        ]


formatAnswer question =
    let
        formatSingleAnswer =
            \x -> li [] [ text x ]
    in
    case question.answer of
        Just anAnswer ->
            text anAnswer

        Nothing ->
            case question.answers of
                Just answers ->
                    ul []
                        (List.map formatSingleAnswer answers)

                Nothing ->
                    text ""
