module PublishButton exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Version exposing (VersionId)
import Msg exposing (..)

view : VersionId -> Html Msg
view selectedVersion =
    button [ onClick ( PublishVersion selectedVersion ) ] [ text "Publish now" ]