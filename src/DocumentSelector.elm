module DocumentSelector exposing(..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)


view documentName =
    div []
        [ span [] [ text "Select document"]
        , input [ value documentName
                , onInput ChangeDocumentName
                , placeholder "document name"
                ] []
        , button [ onClick (LoadDocument documentName)
                 ]
                 [ text "Load"]
        ]