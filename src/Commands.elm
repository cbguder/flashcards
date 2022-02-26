module Commands exposing (..)

import Http
import Json.Decode exposing (field, list, map2, string)
import Msg exposing (Msg(..))
import Question exposing (Question)
import Random
import Random.List


loadQuestions =
    Http.get
        { url = "questions.json"
        , expect = Http.expectJson GotQuestions questionsDecoder
        }


shuffleQuestions questions =
    Random.generate ShuffledQuestions
        (Random.List.shuffle questions)


questionsDecoder =
    list
        (map2 Question
            (field "question" string)
            (field "answer" string)
        )
