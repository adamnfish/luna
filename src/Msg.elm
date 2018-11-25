module Msg exposing (Msg (..), update)

import Array exposing (Array)

import Model exposing (Model, Lifecycle (..), Universe, Body)
import Physics exposing (advanceUniverse)
import Utils exposing (repeatFn)


type Msg
  = NoOp
  | ResizeWindow Int Int
  | MakeStars ( List ( Float, Float ) )
  | Genesis ( List Body )
  | Apocalypse
  | Tick Float
  | TogglePhysics
  | ZoomIn
  | ZoomOut


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    ResizeWindow x y ->
      ( { model | window =
          { width = x
          , height = y
          , zoom = model.window.zoom
          }
        }
      , Cmd.none
      )
    MakeStars stars ->
      ( { model | stars = stars }
      , Cmd.none
      )
    Genesis bodies ->
      ( { model | lifecycle = Run
          { bodies = Array.fromList bodies
          , time = 0
          , showPhysics = False
          }
        }
      , Cmd.none
      )
    Apocalypse ->
      ( { model | lifecycle = Welcome }
      , Cmd.none )
    Tick δt ->
      case model.lifecycle of
        Welcome ->
          ( model, Cmd.none )
        Run universe ->
          let
            -- use 1 frame (~16ms) as our Time Unit
            δms = round ( δt / 16 )
            newUniverse = repeatFn advanceUniverse δms universe
          in
            ( { model | lifecycle = Run newUniverse }
            , Cmd.none
            )
    TogglePhysics ->
      case model.lifecycle of
        Run universe ->
          ( { model | lifecycle = Run
              { universe | showPhysics = not universe.showPhysics }
            }
          , Cmd.none
          )
        _ ->
          ( model, Cmd.none )
    ZoomIn ->
      ( { model | window =
          { zoom = model.window.zoom + 0.1
          , width = model.window.width
          , height = model.window.height
          }
        }
      , Cmd.none
      )
    ZoomOut ->
      ( { model | window =
          { zoom = model.window.zoom - 0.1
          , width = model.window.width
          , height = model.window.height
          }
        }
      , Cmd.none
      )
