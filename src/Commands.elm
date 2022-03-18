module Commands exposing (..)

import Http
import Json.Decode exposing (array, field, list, map3, maybe, string)
import Msg exposing (Msg(..))
import Question exposing (Question)
import Random
import Random.Array


loadQuestions =
    Http.get
        { url = "questions.json"
        , expect = Http.expectJson GotQuestions questionsDecoder
        }


shuffleQuestions questions =
    Random.generate ShuffledQuestions
        (Random.Array.shuffle questions)


questionsDecoder =
    array
        (map3 Question
            (field "question" string)
            (maybe (field "answer" string))
            (maybe (field "answers" (list string)))
        )
