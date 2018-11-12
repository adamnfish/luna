module Examples exposing (slingshot, orbit, eccentricOrbit)

import Model exposing (Body)


orbit : List Body
orbit =
  [ { radius = 11
    , mass = 300
    , position = { x = 500, y = 500 }
    , velocity = { δx = 0, δy = 0 }
    }
  , { radius = 3
    , mass = 1
    , position = { x = 500, y = 300 }
    , velocity = { δx = 1.3, δy = 0 }
    }
  ]

eccentricOrbit : List Body
eccentricOrbit =
  [ { radius = 11
    , mass = 300
    , position = { x = 500, y = 500 }
    , velocity = { δx = 0, δy = 0 }
    }
  , { radius = 3
    , mass = 1
    , position = { x = 500, y = 300 }
    , velocity = { δx = 0.8, δy = 0 }
    }
  ]

slingshot : List Body
slingshot =
  [ { radius = 11
    , mass = 300
    , position = { x = 310, y = 500 }
    , velocity = { δx = 0.5, δy = 0 }
    }
  , { radius = 3
    , mass = 1
    , position = { x = 20, y = 20 }
    , velocity = { δx = 1, δy = 1 }
    }
  ]
