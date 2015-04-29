{-# LANGUAGE TemplateHaskell, MultiParamTypeClasses, FlexibleInstances #-}

module OfficeClimate.User where

import Database.HDBC.PostgreSQL (Connection)
import Database.HDBC.Query.TH (defineTableFromDB, makeRecordPersistableDefault)
import Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import Database.HDBC.Record.Insert (runInsert)
import Database.Record.TH (derivingShow)

import Database.Relational.Query
  ( typedInsert
  , (|$|)
  , Pi
  )

import OfficeClimate.Connection (connect)

$(defineTableFromDB connect driverPostgreSQL "office_climate" "user" [derivingShow])

data InsertUserParams = InsertUserParams { pName ::  String }

makeRecordPersistableDefault ''InsertUserParams

piInsertUser :: Pi User InsertUserParams
piInsertUser = InsertUserParams |$| name'

create :: Connection -> String -> IO Integer
create conn userName = do
  let u = InsertUserParams userName
  runInsert conn (typedInsert tableOfUser piInsertUser) u
