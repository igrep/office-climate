{-# LANGUAGE TemplateHaskell, MultiParamTypeClasses, FlexibleInstances #-}

module OfficeClimate.User where

import Data.Int (Int32)

import Database.HDBC.Query.TH (defineTableFromDB)
import Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import Database.HDBC.Record.Insert (runInsert)
import Database.Record.TH (derivingShow)

import Database.Relational.Query (typedInsert, Insert)

import OfficeClimate.Connection (connect)

$(defineTableFromDB connect driverPostgreSQL "office_climate" "user" [derivingShow])

create :: Int32 -> String -> IO User
create uId userName = do
  conn <- connect

  let u = User uId userName
  _ <- runInsert conn insertUser u

  return u
