module View exposing (view)

import Array exposing (Array)
import Examples exposing (eccentricOrbit, orbit, slingshot, solarSystem)
import Html exposing (Html, a, button, div, h1, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Model exposing (Body, Lifecycle(..), Model, Window)
import Msg exposing (Msg(..))
import Svg exposing (Svg, circle, line, rect, svg)
import Svg.Attributes exposing (cx, cy, fill, height, r, stroke, strokeWidth, viewBox, width, x, x1, x2, y, y1, y2)
import Svg.Events
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
                                (if universe.showPhysics then
                                    "Hide physics"

                                 else
                                    "Show physics"
                                )
                            ]
                        ]
                    ]
                , svg
                    [ viewBox
                        ("0 0 "
                            ++ String.fromInt model.window.width
                            ++ String.fromInt model.window.height
                        )
                    , Svg.Attributes.class "universe"
                    ]
                    ([ rect
                        [ height "100%"
                        , width "100%"
                        , stroke "black"
                        , fill "#111111"
                        ]
                        []
                     ]
                        ++ bodyEls model.window universe.showPhysics universe.bodies
                        ++ displayStars model.window model.stars
                    )
                ]

        Welcome ->
            div []
                [ h1 [] [ text "Luna" ]
                , p []
                    [ button
                        [ onClick (Genesis slingshot)
                        , class "cta-button"
                        ]
                        [ text "Slingshot" ]
                    ]
                , p []
                    [ button
                        [ onClick (Genesis orbit)
                        , class "cta-button"
                        ]
                        [ text "Orbit (regular)" ]
                    ]
                , p []
                    [ button
                        [ onClick (Genesis eccentricOrbit)
                        , class "cta-button"
                        ]
                        [ text "Orbit (eccentric)" ]
                    ]
                , p []
                    [ button
                        [ onClick (Genesis solarSystem)
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


bodyEls : Window -> Bool -> Array Body -> List (Html Msg)
bodyEls window showPhysics bodies =
    flattenList <| Array.toList <| Array.map (bodyEl window showPhysics) bodies


bodyEl : Window -> Bool -> Body -> List (Html Msg)
bodyEl window showPhysics body =
    let
        physics =
            if showPhysics then
                [ line
                    [ x1 (scaleDimension window <| body.position.x)
                    , x2 (scaleDimension window <| body.position.x + (body.velocity.δx * 50))
                    , y1 (scaleDimension window <| body.position.y)
                    , y2 (scaleDimension window <| body.position.y + (body.velocity.δy * 50))
                    , stroke "yellow"
                    , strokeWidth "2"
                    ]
                    []
                , line
                    [ x1 (scaleDimension window <| body.position.x)
                    , x2 (scaleDimension window <| body.position.x + (body.acceleration.δδx * 1000))
                    , y1 (scaleDimension window <| body.position.y)
                    , y2 (scaleDimension window <| body.position.y + (body.acceleration.δδy * 1000))
                    , stroke "red"
                    , strokeWidth "2"
                    ]
                    []
                ]

            else
                []
    in
    [ circle
        [ r (scaleDimension window body.radius)
        , cx (scaleDimension window body.position.x)
        , cy (scaleDimension window body.position.y)
        , fill "#f7f7f7"
        ]
        []
    ]
        ++ physics


displayStars : Window -> List ( Float, Float ) -> List (Html Msg)
displayStars window stars =
    List.map
        (\( starX, starY ) ->
            rect
                [ x (stretchDimension window starX)
                , y (stretchDimension window starY)
                , width "1"
                , height "1"
                , fill "#999999"
                ]
                []
        )
        stars


stretchDimension : Window -> Float -> String
stretchDimension window coord =
    let
        maxDimension =
            max window.width window.height

        scale =
            toFloat maxDimension / 1000.0
    in
    String.fromInt <| round <| (coord * scale)


scaleDimension : Window -> Float -> String
scaleDimension window coord =
    let
        minDimension =
            min window.width window.height

        scale =
            toFloat minDimension / 1000.0
    in
    String.fromFloat <| (coord * scale)
