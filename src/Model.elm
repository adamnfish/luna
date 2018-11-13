module Model exposing (Model (..), Position, Velocity, Acceleration, Body, Universe)

import Array exposing (Array)


type alias Position =
  { x : Float
  , y : Float
  }

type alias Velocity =
  { δx : Float
  , δy : Float
  }

type alias Acceleration =
  { δδx : Float
  , δδy : Float
  }

type alias Body =
  { radius : Float
  , mass : Float
  , position : Position
  , velocity : Velocity
  , acceleration : Acceleration
  }

type alias Universe =
  { bodies : Array Body
  , time : Float
  , showPhysics : Bool
  }

type Model
  = Welcome
  | Run Universe
