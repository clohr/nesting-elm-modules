module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Experiment

main : Program Never Model Msg
main =
    program {init = init, update = update, view = view, subscriptions = (always Sub.none)}

-- INIT

type alias Model =
    { experiment : Experiment.Model
    }

initialModel =
    Model Experiment.initialModel

init : (Model, Cmd Msg)
init =
    (initialModel, Cmd.none)

-- UPDATE

type Msg
    = ExperimentMsg Experiment.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ExperimentMsg submsg ->
            let
                ( updatedExperiment, experimentCmd ) =
                    Experiment.update submsg model.experiment

            in
                ( { model | experiment = updatedExperiment }, Cmd.map ExperimentMsg experimentCmd )


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [text "Experiment"]
        , Html.map ExperimentMsg <| Experiment.view model.experiment
        ]