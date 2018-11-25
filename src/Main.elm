module Main exposing (..)

import Array exposing (Array)
import Browser
import Browser.Dom exposing (getViewport)
import Browser.Events
import Random
import Task

import Examples exposing (orbit, slingshot)
import Model exposing (Model, Lifecycle (..))
import Msg exposing (Msg (..), update)
import Physics exposing (advanceUniverse)
import View exposing (view)

updateWindowDimensions : Result err Browser.Dom.Viewport -> Msg
updateWindowDimensions res =
  case res of
    Ok viewport ->
      ResizeWindow
        ( round viewport.viewport.width )
        ( round viewport.viewport.height )
    Err msg ->
      NoOp

starField : Random.Generator ( List ( Float, Float ) )
starField =
  Random.list 150
    ( Random.pair ( Random.float 0 1000 ) ( Random.float 0 1000 )
    )

init : ( Model, Cmd Msg )
init =
  ( { lifecycle = Welcome
    , window = { width = 1000, height = 1000 }
    , stars = []
    }
  , Cmd.batch
    [ Task.attempt updateWindowDimensions Browser.Dom.getViewport
    , Random.generate MakeStars starField
    ]
  )

-- SUBS

animationTick : Model -> Sub Msg
animationTick model =
  case model.lifecycle of
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
    , subscriptions =
      ( \model ->
        Sub.batch
          [ animationTick model
          , Browser.Events.onResize ResizeWindow
          ]
      )
    }
