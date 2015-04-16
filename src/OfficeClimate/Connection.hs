{-# LANGUAGE FlexibleContexts #-}

module OfficeClimate.Connection
  ( connect
  , run
  ) where

import Database.HDBC.PostgreSQL (connectPostgreSQL, Connection)
import Database.HDBC (IConnection, SqlValue)
import Database.Record (FromSql, ToSql)
import Database.HDBC.Record.Query (runQuery)
import Database.Relational.Query (Relation, relationalQuery)

connect :: IO Connection
connect = connectPostgreSQL "dbname=office_climate"

run :: (Show a, IConnection conn, FromSql SqlValue a, ToSql SqlValue p)
       => conn -> p -> Relation p a -> IO ()
run conn param rel = do
  putStrLn $ "SQL: " ++ show rel
  records <- runQuery conn (relationalQuery rel) param
  mapM_ print records
  putStrLn ""
