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
import SaveButton exposing (..)


main =
  Browser.sandbox { init = init, update = update, view = view }


init : Model
init =
    { documentName = "initial name of the document"
    , versions = [ "first"
                 , "second"
                 , "third"
                 ]
    , selectedVersion = "second"
    , publishedVersion = "third"
    , content = "<initial content here>"
    , label = ""
    }


update: Msg -> Model -> Model
update msg model =
    case msg of
        SelectVersion version -> { model | selectedVersion = version }
        PublishVersion version -> { model | publishedVersion = version }
        ChangeDocumentName name -> { model | documentName = name }
        LoadDocument documentName -> { model | content = "<loaded content from \"" ++ model.documentName ++ "\" here>"}
        ChangeLabel label -> { model | label = label }
        SaveDocument label -> { model | versions = List.append model.versions [label], selectedVersion = label, label = "" }


view: Model -> Html Msg
view model =
    div []
        [ div [ style "border" "thin solid red"
              , style "background" "lightgray"
              , style "padding" "0.5em"
              ]
              [ h1 [] [ text ("Summary")]
              , p [] [ text ("Document name is:" ++ model.documentName)]
              , p [] [ text ("The selected version is: " ++ model.selectedVersion) ]
              , p [] [ text ("The published version is: " ++ model.publishedVersion) ]
              , p [] [ text ("The label is: " ++ model.label) ]
              ]
        , div [] [ DocumentSelector.view model.documentName ]
        , div [] [ VersionSelector.view model.versions model.selectedVersion model.publishedVersion ]
        , div [] [ PublishButton.view model.selectedVersion ]
        , div [] [ textarea [] [ text model.content] ]
        , div [] [ SaveButton.view model.label ]
    ]