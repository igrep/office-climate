{-# LANGUAGE FlexibleContexts #-}

module OfficeClimate.Connection
  ( connect
  , run
  , runI
  ) where

import Database.HDBC.PostgreSQL (connectPostgreSQL, Connection)
import Database.HDBC (IConnection, SqlValue)
import Database.Record (FromSql, ToSql)
import Database.HDBC.Record.Query (runQuery)
import Database.HDBC.Record.Insert (runInsert)
import Database.Relational.Query (Insert)
import Database.Relational.Query (Relation, relationalQuery)

connect :: IO Connection
connect = connectPostgreSQL "dbname='office_climate'"

run :: (Show a, IConnection conn, FromSql SqlValue a, ToSql SqlValue p)
       => conn -> p -> Relation p a -> IO ()
run conn param rel = do
  putStrLn $ "SQL: " ++ show rel
  records <- runQuery conn (relationalQuery rel) param
  mapM_ print records
  putStrLn ""

runI :: (IConnection conn, ToSql SqlValue p)
     => conn -> p -> Insert p -> IO ()
runI conn param ins = do
  putStrLn $ "SQL: " ++ show ins
  num <- runInsert conn ins param
  print num
  putStrLn ""
