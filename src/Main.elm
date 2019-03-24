module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Model exposing (..)
import Msg exposing (..)
import DocumentSelector exposing (..)
import VersionSelector exposing (..)
import PublishButton exposing (..)
import SaveButton exposing (..)


main =
  Browser.element { init = init, subscriptions = subscriptions, update = update, view = view }


init : () -> (Model, Cmd Msg)
init _ = (Model.empty, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SelectVersion version -> ( { model | selectedVersion = version }, Cmd.none )
        
        PublishVersion version -> ( { model | publishedVersion = Just version }, Cmd.none )
        
        ChangeDocumentName name -> ( { model | documentName = name }, Cmd.none )
        
        LoadDocument documentName -> ( { model | content = "<loading content from \"" ++ model.documentName ++ "\" here>" }
                                     , getVersions documentName
                                     )
        
        ChangeLabel label -> ( { model | label = label }, Cmd.none )
        
        SaveDocument label -> ( { model
                                | versions = List.append model.versions [label]
                                , selectedVersion = label
                                , label = "" }
                              , Cmd.none
                              )
        
        GotVersions responseContent -> gotVersions model responseContent


view: Model -> Html Msg
view model =
    div []
        [ div [ style "border" "thin solid red"
              , style "background" "lightgray"
              , style "padding" "0.5em"
              ]
              [ h1 [] [ text ( "Summary" ) ]
              , p [] [ text ( "Document name is:" ++ model.documentName) ]
              , p [] [ text ( "The selected version is: " ++ model.selectedVersion) ]
              , p [] [ text ( "The published version is: " ++  (Maybe.withDefault "None" model.publishedVersion)) ]
              , p [] [ text ( "The label is: " ++ model.label) ]
              ]
        , div [] [ DocumentSelector.view model.documentName ]
        , div [] [ VersionSelector.view model.versions model.selectedVersion model.publishedVersion ]
        , div [] [ PublishButton.view model.selectedVersion ]
        , div [] [ textarea [] [ text model.content] ]
        , div [] [ SaveButton.view model.label ]
    ]