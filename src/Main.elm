module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)
import DocumentSelector exposing (..)
import VersionSelector exposing (..)
import PublishButton exposing (..)


main =
  Browser.sandbox { init = init, update = update, view = view }


init : Model
init =
    Model "initial name of the document"
        [ "first"
        , "second"
        , "third"
        ]
        "second"
        "third"
        "<initial content here>"


update: Msg -> Model -> Model
update msg model =
    case msg of
        SelectVersion version -> { model | selectedVersion = version }
        PublishVersion version -> { model | publishedVersion = version }
        ChangeDocumentName name -> { model | documentName = name }
        LoadDocument documentName -> { model | content = "<loaded content from \"" ++ model.documentName ++ "\" here>"}


view: Model -> Html Msg
view model =
    div []
        [ h1 [] [ text ("Document name is:" ++ model.documentName)]
        , p [] [ text ("The selected version is: " ++ model.selectedVersion) ]
        , p [] [ text ("The published version is: " ++ model.publishedVersion) ]
        , DocumentSelector.view model.documentName
        , VersionSelector.view model.versions model.selectedVersion model.publishedVersion
        , PublishButton.view model.selectedVersion
        , textarea [] [ text model.content]
    ]