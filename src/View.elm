module View exposing (view)

import Array exposing (Array)
import Html exposing (Html, text, div, ul, li, h1, img, p, a, button)
import Html.Attributes exposing (src, class, href)
import Html.Events exposing (onClick)
import Svg exposing (Svg, svg, rect, circle, line)
import Svg.Attributes exposing
  (viewBox, height, width, stroke, strokeWidth, fill, cx, cy, x1, x2, y1, y2, r)
import Svg.Events

import Examples exposing (slingshot, orbit, eccentricOrbit, solarSystem)
import Model exposing (Model, Lifecycle (..), Body, Window)
import Msg exposing (Msg (..))
import Utils exposing (flattenList)


view : Model -> Html Msg
view model =
  case model.lifecycle of
    Run universe ->
      div
        [ class "universe--container" ]
        [ h1 [] [ text "Luna" ]
        , div [ class "controls" ]
          [ p
            []
            [ button
              [ onClick Apocalypse
              , class "controls-button"
              ]
              [ text "Quit" ]
            , button
              [ onClick TogglePhysics
              , class "controls-button"
              ]
              [ text
                (
                  if universe.showPhysics then
                    "Hide physics"
                  else
                    "Show physics"
                )
              ]
            ]
          ]
        , svg
          [ viewBox
            ( "0 0 " ++
              ( String.fromInt model.window.width ) ++
              ( String.fromInt model.window.height )
            )
          , Svg.Attributes.class "universe"
          ]
          ( [ rect
              [ height "100%"
              , width "100%"
              , stroke "black"
              , fill "#111111"
              ]
              []
            ] ++ ( bodyEls model.window universe.showPhysics universe.bodies )
          )
        ]
    Welcome ->
      div []
        [ h1 [] [ text "Luna" ]
        , p []
            [ button
              [ onClick ( Genesis slingshot ) 
              , class "cta-button"
              ]
              [ text "Slingshot" ]
            ]
        , p []
            [ button
              [ onClick ( Genesis orbit ) 
              , class "cta-button"
              ]
              [ text "Orbit (regular)" ]
            ]
        , p []
            [ button
              [ onClick ( Genesis eccentricOrbit ) 
              , class "cta-button"
              ]
              [ text "Orbit (eccentric)" ]
            ]
        , p []
            [ button
              [ onClick ( Genesis solarSystem ) 
              , class "cta-button"
              ]
              [ text "Solar system" ]
            ]
        , p
          [ class "info-box" ]
          [ text "Source code available at "
          , a
            [ href "https://github.com/adamnfish/luna" ]
            [ text "github.com/adamnfish/luna" ]
          ]
        ]

bodyEls : Window -> Bool -> Array Body -> List ( Html Msg )
bodyEls window showPhysics bodies =
  flattenList <| Array.toList <| Array.map ( bodyEl window showPhysics ) bodies

bodyEl : Window -> Bool -> Body -> List ( Html Msg )
bodyEl window showPhysics body =
  let
    physics =
      if showPhysics then
        [ line
          [ x1 ( scaleDimension window <| body.position.x )
          , x2 ( scaleDimension window <| body.position.x + ( body.velocity.δx * 50 ) )
          , y1 ( scaleDimension window <| body.position.y )
          , y2 ( scaleDimension window <| body.position.y + ( body.velocity.δy * 50 ) )
          , stroke "yellow"
          , strokeWidth "2"
          ]
          []
        , line
          [ x1 ( scaleDimension window <| body.position.x )
          , x2 ( scaleDimension window <| body.position.x + ( body.acceleration.δδx * 1000 ) )
          , y1 ( scaleDimension window <| body.position.y )
          , y2 ( scaleDimension window <| body.position.y + ( body.acceleration.δδy * 1000 ) )
          , stroke "red"
          , strokeWidth "2"
          ]
          []
        ]
      else
        []
  in
    [ circle
      [ r ( scaleDimension window body.radius )
      , cx ( scaleDimension window body.position.x )
      , cy ( scaleDimension window body.position.y )
      , fill "#f7f7f7"
      ]
      []
    ] ++ physics

scaleDimension : Window -> Float -> String
scaleDimension window coord =
  let
    minDimension = min window.width window.height
    scale = toFloat minDimension / 1000
  in
    String.fromInt <| round <| ( coord * scale )
