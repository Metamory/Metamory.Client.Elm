module VersionSelector exposing (view, getVersions, gotVersions)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as D

import Msg exposing (..)
import Model exposing (..)
import Version exposing (VersionId)


view : (List VersionId) -> VersionId -> (Maybe VersionId) -> Html Msg
view versions selectedVersion publishedVersion = 
    div []
        [ span [] [ text "Select version" ]
        , select [on "change" <| D.map SelectVersion targetValue ]
                 (List.map (\version -> viewOption version selectedVersion publishedVersion) versions)
        ]


viewOption : VersionId -> VersionId -> (Maybe VersionId) -> Html Msg
viewOption version selectedVersion publishedVersion = 
    option [ Html.Attributes.value version
           , selected <| version == selectedVersion
           ]
           [ text <| if version == Maybe.withDefault "" publishedVersion
                        then version ++ "*"
                        else version
           ]


getVersions : String -> Cmd Msg
getVersions documentName =
    let
        url = "https://localhost:5001/content/testsite1/testcontent1/versions"
    in
        Http.get { url = url
                 , expect = Http.expectJson GotVersions <| D.field "versions" <| D.list <| D.field "versionId" D.string
                 }


gotVersions : Model -> (Result Http.Error (List String)) -> (Model, Cmd msg)
gotVersions model responseContent =
    case responseContent of
            Ok versions -> ( { model | versions = versions
                                , selectedVersion = List.reverse versions |> List.head |> Maybe.withDefault ""
                                -- TODO publishedVersion = ...
                                }
                            , Cmd.none )
            Err _ -> ( model, Cmd.none )