module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)
import VersionSelector exposing (..)
import PublishButton exposing (..)


main =
  Browser.sandbox { init = init, update = update, view = view }


init : Model
init =
    Model 0
        [ "first"
        , "second"
        , "third"
        ]
        "second"
        "third"


update: Msg -> Model -> Model
update msg model =
    case msg of
        SelectVersion version -> { model | selectedVersion = version }
        PublishVersion version -> { model | publishedVersion = version }


view: Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Hello world!"]
        , p [] [ text ("The selected version is: " ++ model.selectedVersion) ]
        , p [] [ text ("The published version is: " ++ model.publishedVersion) ]
        , VersionSelector.view model.versions model.selectedVersion model.publishedVersion
        , PublishButton.view model.selectedVersion
    ]