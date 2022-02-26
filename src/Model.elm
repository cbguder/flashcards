module Model exposing (..)

import Commands exposing (loadQuestions)
import Msg exposing (Msg(..))
import Question exposing (Question)


type Model
    = Loading
    | Failure
    | Question LoadedModel
    | Answer LoadedModel
    | Done LoadedModel


type alias LoadedModel =
    { questions : List Question
    , index : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading, loadQuestions )
