module Msg exposing (..)

import Http
import Json.Decode exposing (..)

import Version exposing (VersionId)


type Msg = SelectVersion VersionId
         | PublishVersion VersionId
         | ChangeDocumentName String
         | LoadDocument String
         | ChangeLabel String
         | SaveDocument String
         | GotVersions (Result Http.Error (List String))


getVersions : String -> Cmd Msg
getVersions documentName =
    let
        url = "https://localhost:5001/content/testsite1/testcontent1/versions"
    in
        Http.get { url = url
                 , expect = Http.expectJson GotVersions (Json.Decode.list (Json.Decode.field "versionId" Json.Decode.string))
                 }
