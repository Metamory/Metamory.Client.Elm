module Msg exposing (..)

import Version exposing (VersionId)

type Msg = SelectVersion VersionId
         | PublishVersion VersionId
