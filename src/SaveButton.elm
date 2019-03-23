module SaveButton exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)


view : String -> Html Msg
view label =
    div []
        [ input [ value label
                , onInput ChangeLabel
                , placeholder "label"
                ] []
        , button [ onClick <| SaveDocument label
                 ]
                 [ text "Save"]
        ]