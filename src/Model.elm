module Model exposing (..)

import Version exposing (VersionId)

type alias Model = { documentName: String
                   , versions: List VersionId
                   , selectedVersion: VersionId
                   , publishedVersion: (Maybe VersionId)
                   , content: String
                   , label: String
                   }


empty : Model
empty =
    --TODO: make an empty model
    { documentName = "testcontent1"
    , versions = []
    , selectedVersion = ""
    , publishedVersion = Nothing
    , content = "<initial content here>"
    , label = ""
    }
