module View exposing (view)

import Array exposing (Array)
import Html exposing (Html, text, div, ul, li, h1, img, p, a, button)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)
import Svg exposing (Svg, svg, rect, circle)
import Svg.Attributes exposing
  (viewBox, height, width, stroke, strokeWidth, fill, cx, cy, r)
import Svg.Events

import Examples exposing (slingshot, orbit, eccentricOrbit, solarSystem)
import Model exposing (Model (..), Body)
import Msg exposing (Msg (..))


view : Model -> Html Msg
view model =
  case model of
    Run universe ->
      div
        [ class "universe--container" ]
        [ h1 [] [ text "Luna" ]
        , div []
          [ p
            []
            [ button
              [ onClick Apolalypse
              , class "cta-button"
              ]
              [ text "Quit" ]
            ]
          ]
        , svg
          [ viewBox "0 0 1000 1000"
          , Svg.Attributes.class "universe"
          ]
          (
            [ rect
              [ height "1000"
              , width "1000"
              , stroke "black"
              , fill "#666666"
              ]
              []
            ] ++ ( bodyEls universe.bodies )
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
        ]

bodyEls : Array Body -> List ( Html Msg )
bodyEls bodies =
  Array.toList <| Array.map bodyEl bodies

bodyEl : Body -> Html Msg
bodyEl body =
  circle
    [ r ( String.fromInt <| round body.radius )
    , cx ( String.fromInt <| round body.position.x )
    , cy ( String.fromInt <| round body.position.y )
    , fill "#f7f7f7"
    ]
    []
