module Model exposing (Model, Lifecycle (..), Position, Velocity, Acceleration, Body, Universe, Window)

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

type alias Window =
  { width : Int
  , height : Int
  , zoom : Float
  }

type Lifecycle
  = Welcome
  | Run Universe

type alias Model =
  { window : Window
  , lifecycle : Lifecycle
  , stars : List ( Float, Float )
  }
