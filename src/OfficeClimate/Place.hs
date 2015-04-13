{-# LANGUAGE TemplateHaskell, MultiParamTypeClasses, FlexibleInstances #-}

module OfficeClimate.Place where

import Database.HDBC.Query.TH (defineTableFromDB)
import Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import Database.Record.TH (derivingShow)

import OfficeClimate.Connection (connect)

$(defineTableFromDB connect driverPostgreSQL "office_climate" "place" [derivingShow])
