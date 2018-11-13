module Examples exposing (slingshot, orbit, eccentricOrbit, solarSystem)

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
    , velocity = { δx = 1, δy = 0.6 }
    }
  ]

slingshot : List Body
slingshot =
  [ { radius = 11
    , mass = 300
    , position = { x = 400, y = 500 }
    , velocity = { δx = 0.5, δy = 0 }
    }
  , { radius = 3
    , mass = 1
    , position = { x = 700, y = 300 }
    , velocity = { δx = -0.5, δy = 0.5 }
    }
  ]

solarSystem : List Body
solarSystem =
  [ { radius = 20
    , mass = 1000
    , position = { x = 500, y = 500 }
    , velocity = { δx = -0.005, δy = -0.0001 }
    }
  , { radius = 3
    , mass = 30
    , position = { x = 500, y = 400 }
    , velocity = { δx = 3, δy = 0 }
    }
  , { radius = 5
    , mass = 40
    , position = { x = 500, y = 850 }
    , velocity = { δx = -1.7, δy = 0 }
    }
  , { radius = 1
    , mass = 1
    , position = { x = 700, y = 350 }
    , velocity = { δx = 1, δy = 1.5 }
    }
  , { radius = 1
    , mass = 1
    , position = { x = 300, y = 350 }
    , velocity = { δx = 1.2, δy = -1.5 }
    }
  , { radius = 1
    , mass = 1
    , position = { x = 250, y = 480 }
    , velocity = { δx = 0.1, δy = -1.8 }
    }
  ]
