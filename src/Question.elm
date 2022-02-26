module Question exposing (..)


type alias Question =
    { question : String
    , answer : Maybe String
    , answers : Maybe (List String)
    }
