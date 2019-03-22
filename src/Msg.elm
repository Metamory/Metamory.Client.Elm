module Msg exposing (..)

import Version exposing (VersionId)

type Msg = SelectVersion VersionId
         | PublishVersion VersionId
         | ChangeDocumentName String
         | LoadDocument String
         | ChangeLabel String
         | SaveDocument String
