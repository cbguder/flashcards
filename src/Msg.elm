module Msg exposing (..)

import Http
import Question exposing (Question)


type Msg
    = GotQuestions (Result Http.Error (List Question))
    | ShuffledQuestions (List Question)
    | NextQuestion
    | PreviousQuestion
    | NoOp
