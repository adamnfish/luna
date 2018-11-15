module Physics exposing (advanceUniverse, distanceBetween, accelerationDueToGravity)

import Array exposing (Array)

import Model exposing (Position, Velocity, Acceleration, Body, Universe)
import Utils exposing (arrMapWithOthers)


advanceUniverse : Universe -> Universe
advanceUniverse prevUniverse =
  let
    bodies = arrMapWithOthers advanceBody prevUniverse.bodies
  in
    { prevUniverse | bodies = bodies
                   , time = prevUniverse.time + 1
    }


advanceBody : Body -> Array Body -> Body
advanceBody body otherBodies =
  let
    currentAcceleration = accelerationDueToGravity body otherBodies
    newVelocity = applyAcceleration currentAcceleration body.velocity
    newPosition = applyVelocity newVelocity body.position
  in
    { body | velocity = newVelocity
           , position = newPosition
           , acceleration = currentAcceleration
    }

-- gravitational constant
-- tweak this to tune the acceleration of the universe
g : Float
g = 1

fma : Float -> Body -> Float
fma force body = force / body.mass

forceDueToGravity : Body -> Array Body -> Acceleration
forceDueToGravity body otherBodies =
  let
    zero = { δδx = 0, δδy = 0 }
    combine : Body -> Acceleration -> Acceleration
    combine otherBody accumulatedAcceleration =
      let
        distance = distanceBetween body.position otherBody.position
        xDistance = otherBody.position.x - body.position.x
        yDistance = otherBody.position.y - body.position.y
        accelerationMagnitude =
          if distance == 0 then
            0
          else
            ( ( g * body.mass * otherBody.mass ) / ( distance ^ 2 ) )
        acceleration =
          { δδx = accelerationMagnitude * ( xDistance / distance )
          , δδy = accelerationMagnitude * ( yDistance / distance )
          }
      in
        addAcceleration
          accumulatedAcceleration
          acceleration
  in
    Array.foldl combine zero otherBodies

accelerationDueToGravity : Body -> Array Body -> Acceleration
accelerationDueToGravity body otherBodies =
  let
    force = forceDueToGravity body otherBodies
  in
    { δδx = fma force.δδx body
    , δδy = fma force.δδy body
    }

distanceBetween : Position -> Position -> Float
distanceBetween p1 p2 =
  sqrt ( ( ( p1.x - p2.x ) ^ 2 ) + ( ( p1.y - p2.y ) ^ 2 ) )


-- utils

addAcceleration : Acceleration -> Acceleration -> Acceleration
addAcceleration a1 a2 =
  { δδx = a1.δδx + a2.δδx
  , δδy = a1.δδy + a2.δδy
  }

applyAcceleration : Acceleration -> Velocity -> Velocity
applyAcceleration acceleration velocity =
  { δx = velocity.δx + acceleration.δδx
  , δy = velocity.δy + acceleration.δδy
  }

applyVelocity : Velocity -> Position -> Position
applyVelocity velocity position =
  { x = position.x + velocity.δx
  , y = position.y + velocity.δy
  }
