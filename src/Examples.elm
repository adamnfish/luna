module Examples exposing (orbit, slingshot)

import Model exposing (Body)


orbit : List Body
orbit =
  [ { radius = 11
    , mass = 100
    , position = { x = 500, y = 500 }
    , velocity = { δx = 0, δy = 0 }
    }
  , { radius = 3
    , mass = 1
    , position = { x = 400, y = 400 }
    , velocity = { δx = 1, δy = 0 }
    }
  ]

slingshot : List Body
slingshot =
  [ { radius = 11
    , mass = 100
    , position = { x = 500, y = 500 }
    , velocity = { δx = 0, δy = 0 }
    }
  , { radius = 3
    , mass = 1
    , position = { x = 20, y = 20 }
    , velocity = { δx = 1, δy = 0 }
    }
  ]
