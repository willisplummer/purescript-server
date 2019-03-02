module Router where

import HTTPure as HTTPure

router :: HTTPure.Request -> HTTPure.ResponseM
router {} = HTTPure.ok "hello world!"
