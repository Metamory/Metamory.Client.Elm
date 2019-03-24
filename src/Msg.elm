module Msg exposing (..)

import Http
import Json.Decode as D

import Model exposing (Model)
import Version exposing (VersionId)


type Msg = SelectVersion VersionId
         | PublishVersion VersionId
         | ChangeDocumentName String
         | LoadDocument String
         | ChangeLabel String
         | SaveDocument String
         | GotVersions (Result Http.Error (List String))

