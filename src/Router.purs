module Router where

import Prelude (($))
import HTTPure as HTTPure
import Data.Argonaut (class EncodeJson, encodeJson, jsonEmptyObject, (:=), (~>))
import Data.Argonaut.Core (toString)
import Data.Maybe (Maybe(..))

newtype Judgeable = Judgeable {
  id :: Int
, name :: String
, imageUrl :: String
}

banana :: Judgeable
banana = Judgeable {
  id: 1
, name: "banana"
, imageUrl: "fakeUrl"
}

instance encodeJsonJudgeable :: EncodeJson Judgeable where
  encodeJson (Judgeable thing)
     = "id" := thing.id
    ~> "name" := thing.name
    ~> "imageUrl" := thing.imageUrl
    ~> jsonEmptyObject

getJudgeableThingHandler :: HTTPure.ResponseM
getJudgeableThingHandler =
  case maybeResponseString of
    (Just stringifiedJson) -> HTTPure.ok stringifiedJson
    Nothing -> HTTPure.internalServerError "something went wrong"
  where maybeResponseString = toString $ encodeJson banana

router :: HTTPure.Request -> HTTPure.ResponseM
router { body, path: [ "things" ], method: HTTPure.Post }  = HTTPure.ok body
router { body, path: [ "things", "new" ], method: HTTPure.Post } = HTTPure.ok body
router {} = getJudgeableThingHandler
