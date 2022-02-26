module Main exposing (..)

import Browser
import Model exposing (Model, init)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
