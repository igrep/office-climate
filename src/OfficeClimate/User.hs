{-# LANGUAGE TemplateHaskell, MultiParamTypeClasses, FlexibleInstances #-}

module OfficeClimate.User
  ( User(..)
  , createStatement
  , create
  )
where

import Database.HDBC.Query.TH (defineTableFromDB)
import Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import Database.HDBC.Record.Insert (prepareInsert, runPreparedInsert)
import Database.Record.TH (derivingShow)

import Database.Relational.Query (typedInsert, Insert)

import OfficeClimate.Connection (connect)

$(defineTableFromDB connect driverPostgreSQL "office_climate" "user" [derivingShow])

createStatement :: Insert String
createStatement = typedInsert tableOfUser name'

create :: String -> IO Integer
create userName = do
  conn <- connect
  ins <- prepareInsert conn createStatement
  runPreparedInsert ins userName
