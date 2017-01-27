module Experiment exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import Types exposing (ExperimentType, ConfigType, CssType)
import Config

-- MODEL

type alias Model =
    ExperimentType

initialModel =
    ExperimentType "My First Experiment"
        <| ConfigType "Config #1"
        <| [ CssType "Arial" "#dddddd", CssType "Verdana" "#000000"]

-- UPDATE

type Msg
    = UpdateName String
    | ConfigMsg Config.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UpdateName str ->
            ({ model | name = str}, Cmd.none)

        ConfigMsg submsg ->
            let
                ( updatedConfig, configCmd ) =
                    Config.update submsg model.config
            in
                ( { model | config = updatedConfig }, Cmd.map ConfigMsg configCmd )

-- VIEW

view : Model -> Html Msg
view model = 
    div []
        [ fieldset []
            [ label [] [text "Name"]
            , input [ type_ "text", value model.name, onInput UpdateName ] []
            ]
        , Html.map ConfigMsg <| Config.view model.config
        ]