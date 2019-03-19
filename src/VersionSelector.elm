module VersionSelector exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Version exposing (VersionId)
import Json.Decode exposing (..)


viewOption : VersionId -> VersionId -> VersionId -> Html Msg
viewOption version selectedVersion publishedVersion = 
    option [ Html.Attributes.value version
           , selected (version == selectedVersion)
           ]
           [ text (if version == publishedVersion then version ++ "*" else version) ]


versionDecoder : Msg
versionDecoder =
    targetValue "value" String |> andThen (\val ->  (SelectVersion (Json.Decode.map) versionDecoder))


view : (List VersionId) -> VersionId -> VersionId -> Html Msg
view versions selectedVersion publishedVersion = 
    div []
        [ span [] [ text "Select version" ]
        , select [] (List.map (\version -> viewOption version selectedVersion publishedVersion) versions)
        ]