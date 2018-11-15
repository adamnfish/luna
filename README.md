# Luna

> The gravity assist maneuver was first used in 1959 when
> Luna 3 photographed the far side of Earth's Moon.
>
> – [en.wikipedia.org/wiki/Luna_3](https://en.wikipedia.org/wiki/Luna_3)

App to demonstrate gravitational slingshot maneuvers.

https://adamnfish.github.io/luna/index.html

## Source code

This is an Elm application built using
[create-elm-app](https://github.com/halfzebra/create-elm-app). The
program runs from [`src/Main.elm`](src/Main.elm), which provides the
initial state and browser integration (including a subscription to
`requestAnimationFrame`). Updates to the state come from messages,
which are processed in [`src/Msg.elm`](src/Msg.elm). The program's
datastructures are definined in [`src/Model.elm`](src/Model.elm).
Lastly, the View renders the current model after every update and is
responsible for producing the app's HTML interface. This is found in
[`src/View.elm`](src/View.elm).

Most of Luna's tricky logic is modelling the physics of bodies in 2D
space. This functionality can be found in
[`src/Physics.elm`](src/Physics.elm).

