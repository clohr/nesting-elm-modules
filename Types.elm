module Types exposing (..)

type alias ExperimentType = 
    { name : String
    , config : ConfigType
    }

type alias ConfigType = 
    { name : String
    , css : List CssType
    }

type alias CssType =
    { font : String
    , background : String 
    }
