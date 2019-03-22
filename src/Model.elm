module Model exposing (..)

import Version exposing (VersionId)

type alias Model = { documentName: String
                   , versions: List VersionId
                   , selectedVersion: VersionId
                   , publishedVersion: VersionId
                   , content: String
                   , label: String
                   }