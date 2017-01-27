module Css exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import Types exposing (CssType)
import Array

-- MODEL

type alias Index =
    Int

type alias Model =
    List CssType


-- UPDATE

type Msg 
    = UpdateFont Index String
    | UpdateBackground Index String
    

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    let
        modelArray = Array.fromList model
    in
        case msg of
            UpdateFont idx val ->
                let
                    origCss = Maybe.withDefault (CssType "" "") <| Array.get idx <| modelArray

                    updatedCss = Array.toList <| Array.set idx {origCss | font = val} <| modelArray
                in
                    (updatedCss, Cmd.none)

            UpdateBackground idx val ->
                let
                    origCss = Maybe.withDefault (CssType "" "") <| Array.get idx <| modelArray

                    updatedCss = Array.toList <| Array.set idx {origCss | background = val} <| modelArray
                in
                    (updatedCss, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model = 
    let
        indexedList = List.indexedMap (,) model
    in
        div []
            [ div [] (List.map renderCssFields indexedList)
            ]

renderCssFields : (Index, CssType) -> Html Msg
renderCssFields (idx, css) = 
    div []
        [ h2 [] [text "CSS"]
        , fieldset []
            [ label [] [text "Font"]
            , input [ type_ "text", value css.font, onInput <| UpdateFont idx] []
            ]
        , fieldset []
            [ label [] [text "Background"]
            , input [ type_ "text", value css.background, onInput <| UpdateBackground idx] []
            ]
        ]