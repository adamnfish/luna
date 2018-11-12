module Msg exposing (Msg (..), update)

import Array exposing (Array)

import Model exposing (Model (..), Universe, Body)
import Physics exposing (advanceUniverse)


type Msg
  = NoOp
  -- A compiler bug in 0.19 prevents use of Array in Msg
  -- so we use List here to kick it off and then convert when it's used elsewhere
  | Genesis ( List Body )
  | Apolalypse
  | Tick Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    Genesis bodies ->
      ( Run
        { bodies = Array.fromList bodies
        , time = 0
        }
      , Cmd.none
      )
    Apolalypse ->
      ( Setup Array.empty, Cmd.none )
    Tick δt ->
      case model of
        Setup _ ->
          ( model, Cmd.none )
        Run universe ->
          ( Run ( advanceUniverse universe δt )
          , Cmd.none
          )

