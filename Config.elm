module Config exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import Types exposing (ConfigType)
import Css

-- MODEL

type alias Model =
    ConfigType

-- UPDATE

type Msg
    = UpdateName String
    | CssMsg Css.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UpdateName str ->
            ({ model | name = str}, Cmd.none)

        CssMsg submsg ->
            let
                ( updatedCssModel, cssCmd ) =
                    Css.update submsg model.css
            in
                ( { model | css = updatedCssModel }, Cmd.map CssMsg cssCmd )

-- VIEW

view : Model -> Html Msg
view model = 
    div []
        [ fieldset []
            [ label [] [text "Name"]
            , input [ type_ "text", value model.name, onInput UpdateName ] []
            ]
        , Html.map CssMsg <| Css.view model.css
        ]