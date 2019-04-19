module Examples exposing (slingshot, orbit, eccentricOrbit, solarSystem, solarSystem2)

import Model exposing (Body)


orbit : List Body
orbit =
  [ { radius = 11
    , mass = 300
    , position = { x = 500, y = 500 }
    , velocity = { δx = 0, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 3
    , mass = 1
    , position = { x = 500, y = 300 }
    , velocity = { δx = 1.3, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  ]

eccentricOrbit : List Body
eccentricOrbit =
  [ { radius = 11
    , mass = 300
    , position = { x = 500, y = 500 }
    , velocity = { δx = 0, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 3
    , mass = 1
    , position = { x = 500, y = 300 }
    , velocity = { δx = 1, δy = 0.6 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  ]

slingshot : List Body
slingshot =
  [ { radius = 11
    , mass = 300
    , position = { x = 400, y = 500 }
    , velocity = { δx = 0.5, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 3
    , mass = 1
    , position = { x = 700, y = 300 }
    , velocity = { δx = -0.5, δy = 0.5 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  ]

solarSystem : List Body
solarSystem =
  [ { radius = 20
    , mass = 1000
    , position = { x = 500, y = 500 }
    , velocity = { δx = -0.005, δy = -0.0001 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 3
    , mass = 30
    , position = { x = 500, y = 400 }
    , velocity = { δx = 3, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 5
    , mass = 40
    , position = { x = 500, y = 850 }
    , velocity = { δx = -1.7, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 1
    , mass = 1
    , position = { x = 700, y = 350 }
    , velocity = { δx = 1, δy = 1.5 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 1
    , mass = 1
    , position = { x = 300, y = 350 }
    , velocity = { δx = 1.2, δy = -1.5 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 1
    , mass = 1
    , position = { x = 250, y = 480 }
    , velocity = { δx = 0.1, δy = -1.8 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  ]

solarSystem2 : List Body
solarSystem2 =
  [ { radius = 20
    , mass = 100
    , position = { x = 500, y = 500 }
    , velocity = { δx = 0, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 3
    , mass = 5
    , position = { x = 500, y = 600 }
    , velocity = { δx = -1, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 3
    , mass = 4
    , position = { x = 500, y = 300 }
    , velocity = { δx = 0.77, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 1
    , mass = 1
    , position = { x = 500, y = 200 }
    , velocity = { δx = 0.6, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 1
    , mass = 1
    , position = { x = 200, y = 500 }
    , velocity = { δx = 0, δy = -0.6 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 1
    , mass = 1
    , position = { x = 500, y = 100 }
    , velocity = { δx = 0.48, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  , { radius = 1
    , mass = 1
    , position = { x = 500, y = 950 }
    , velocity = { δx = -0.5, δy = 0 }
    , acceleration = { δδx = 0, δδy = 0 }
    }
  ]
