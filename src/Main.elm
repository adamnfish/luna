module Main exposing (..)

import Array exposing (Array)
import Browser
import Browser.Events

import Examples exposing (orbit, slingshot)
import Model exposing (Model (..))
import Msg exposing (Msg (..), update)
import Physics exposing (advanceUniverse)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
  ( Welcome
  , Cmd.none
  )


-- SUBS

animationTick : Model -> Sub Msg
animationTick model =
  case model of
    Welcome ->
      Sub.none
    Run _ ->
      Browser.Events.onAnimationFrameDelta Tick


---- PROGRAM ----

main : Program () Model Msg
main =
  Browser.element
    { view = view
    , init = \_ -> init
    , update = update
    , subscriptions = \model -> animationTick model
    }
