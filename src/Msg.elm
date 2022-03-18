module Msg exposing (..)

import Array exposing (Array)
import Http
import Question exposing (Question)


type Msg
    = GotQuestions (Result Http.Error (Array Question))
    | ShuffledQuestions (Array Question)
    | NextQuestion
    | PreviousQuestion
    | NoOp
