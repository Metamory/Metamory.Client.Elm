module Model exposing (..)

import Version exposing (VersionId)

type alias Model = { counter: Int
                   , versions: List VersionId
                   , selectedVersion: VersionId
                   , publishedVersion: VersionId
                   }