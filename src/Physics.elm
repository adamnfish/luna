module Physics exposing (advanceUniverse, distanceBetween, accelerationDueToGravity)

import Array exposing (Array)

import Model exposing (Position, Velocity, Acceleration, Body, Universe)
import Utils exposing (arrMapWithOthers)


advanceUniverse : Universe -> Float -> Universe
advanceUniverse prevUniverse δms =
  let
    bodies = arrMapWithOthers ( advanceBody δms ) prevUniverse.bodies
  in
    { prevUniverse | bodies = bodies
                   , time = prevUniverse.time + δms
    }


advanceBody : Float -> Body -> Array Body -> Body
advanceBody δms body otherBodies =
  let
    currentAcceleration = accelerationDueToGravity body otherBodies
    newVelocity = applyAcceleration currentAcceleration body.velocity δms
    newPosition = applyVelocity newVelocity body.position δms
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
    initialAcceleration = { δδx = 0, δδy = 0 }
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
    Array.foldl combine initialAcceleration otherBodies

accelerationDueToGravity : Body -> Array Body -> Acceleration
accelerationDueToGravity body otherBodies =
  let
    force = forceDueToGravity body otherBodies
    fx = force.δδx
    fy = force.δδy
  in
    { δδx = fma fx body
    , δδy = fma fy body
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

scaleAcceleration : Float -> Acceleration -> Acceleration
scaleAcceleration scale acceleration =
  { δδx = acceleration.δδx * scale
  , δδy = acceleration.δδy * scale
  }

scaleVelocity : Float -> Velocity -> Velocity
scaleVelocity scale velocity =
  { δx = velocity.δx * scale
  , δy = velocity.δy * scale
  }

-- we'll treat 16ms as our Time Unit (roughly one frame)
-- but the subscription gives us the diff in ms
applyAcceleration : Acceleration -> Velocity -> Float -> Velocity
applyAcceleration acceleration velocity δms =
  let
    δv = scaleAcceleration ( δms / 16 ) acceleration
    δδx = δv.δδx
    δδy = δv.δδy
  in
    { δx = velocity.δx + δδx
    , δy = velocity.δy + δδy
    }

-- we'll treat 16ms as our Time Unit (roughly one frame)
-- but the subscription gives us the diff in ms
applyVelocity : Velocity -> Position -> Float -> Position
applyVelocity velocity position δms =
  let
    v = scaleVelocity ( δms / 16 ) velocity
    δx = v.δx
    δy = v.δy
  in
    { x = position.x + δx
    , y = position.y + δy
    }
