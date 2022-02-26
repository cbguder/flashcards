module View exposing (..)

import Array
import Html exposing (Html, div, p, span, text)
import Html.Attributes exposing (class, style)
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

        Success loadedModel ->
            successView loadedModel


emojiView emoji footnote =
    inContainer
        []
        [ p [] [ text emoji ] ]
        [ p [] [ text footnote ] ]


inContainer attrs questionChildren footnoteChildren =
    let
        containerAttrs =
            attrs ++ [ class "container vh-100 user-select-none" ]
    in
    div
        containerAttrs
        [ div
            [ class "question" ]
            questionChildren
        , div
            [ class "footnote text-muted" ]
            footnoteChildren
        ]


successView model =
    let
        currentQuestion =
            Array.get model.index (Array.fromList model.questions)
                |> Maybe.map (\q -> q.question)
                |> Maybe.withDefault "-"
    in
    inContainer
        [ onClick NextQuestion ]
        [ p [] [ text currentQuestion ] ]
        [ p [] [ text "Click to advance" ] ]
