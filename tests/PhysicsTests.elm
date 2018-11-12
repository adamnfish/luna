module PhysicsTests exposing (..)

import Array exposing (Array)
import Expect
import Test exposing (..)

import Physics exposing (distanceBetween, accelerationDueToGravity)


all : Test
all =
  describe "physics tests"
    [ describe "distanceBetween"
      [ test "returns correct value for a linear example" <|
        \_ ->
          Expect.equal
            4
            ( distanceBetween
              { x = 0
              , y = 0
              }
              { x = 0
              , y = 4
              }
            )
      , test "returns correct value for a triangle" <|
        \_ ->
          Expect.equal
            5
            ( distanceBetween
              { x = 3
              , y = 0
              }
              { x = 0
              , y = 4
              }
            )
      ]
    , describe "accelerationDueToGravity"
        [ test "x is non-zero" <|
          \_ ->
            let
              body =
                { radius = 1
                , mass = 1000
                , position = { x = 0, y = 0 }
                , velocity = { δx = 0, δy = 0 }
                }
              otherBody =
                { radius = 1
                , mass = 1000
                , position = { x = 10, y = 10 }
                , velocity = { δx = 0, δy = 0 }
                }
              acceleration = accelerationDueToGravity body ( Array.fromList [ otherBody ] )
            in
              Expect.greaterThan 0
                acceleration.δδx
        , test "y is non-zero" <|
          \_ ->
            let
              body =
                { radius = 1
                , mass = 1000
                , position = { x = 0, y = 0 }
                , velocity = { δx = 0, δy = 0 }
                }
              otherBody =
                { radius = 1
                , mass = 1000
                , position = { x = 10, y = 10 }
                , velocity = { δx = 0, δy = 0 }
                }
              acceleration = accelerationDueToGravity body ( Array.fromList [ otherBody ] )
            in
              Expect.greaterThan 0
                acceleration.δδy
        ]
    ]
