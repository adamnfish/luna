module Msg exposing (Msg (..), update)

import Array exposing (Array)

import Model exposing (Model (..), Universe, Body)
import Physics exposing (advanceUniverse)
import Utils exposing (repeatFn)


type Msg
  = NoOp
  | Genesis ( List Body )
  | Apocalypse
  | Tick Float
  | TogglePhysics


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    Genesis bodies ->
      ( Run
        { bodies = Array.fromList bodies
        , time = 0
        , showPhysics = False
        }
      , Cmd.none
      )
    Apocalypse ->
      ( Welcome, Cmd.none )
    Tick δt ->
      case model of
        Welcome ->
          ( model, Cmd.none )
        Run universe ->
          let
            -- use 1 frame (~16ms) as our Time Unit
            δms = round ( δt / 16 )
            newUniverse = repeatFn advanceUniverse δms universe
          in
            ( Run newUniverse
            , Cmd.none
            )
    TogglePhysics ->
      case model of
        Run universe ->
          ( Run
            { universe | showPhysics = not universe.showPhysics }
          , Cmd.none
          )
        _ ->
          ( model, Cmd.none )
