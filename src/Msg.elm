module Msg exposing (Msg (..), update)

import Array exposing (Array)

import Model exposing (Model, Lifecycle (..), Universe, Body, Window)
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
  | PanX Int
  | PanY Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    ResizeWindow w h ->
      ( updateWindow model
        ( \window -> { window | width = w
                              , height = h
                     }
        )
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
                , window =
                  { x = 0
                  , y = 0
                  , zoom = 1.0
                  , width = model.window.width
                  , height = model.window.height
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
      let
        xPan = model.window.width * ( round <| 0.1 / 2 )
        yPan = model.window.height * ( round <| 0.1 / 2 )
      in
        ( updateWindow model
          ( \window -> { window | zoom = window.zoom + 0.1
                                , x = window.x + xPan
                                , y = window.y + yPan
                       }
          )
        , Cmd.none
        )
    ZoomOut ->
      ( updateWindow model
        ( \window -> { window | zoom = window.zoom - 0.1 } )
      , Cmd.none
      )
    PanX δx ->
      ( updateWindow model
        ( \window -> { window | x = window.x + δx } )
      , Cmd.none
      )
    PanY δy ->
      ( updateWindow model
        ( \window -> { window | y = window.y + δy } )
      , Cmd.none
      )

updateWindow : Model -> ( Window -> Window ) -> Model
updateWindow model f =
  { model | window = f model.window }
