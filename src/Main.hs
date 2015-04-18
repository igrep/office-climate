{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import Language.Haskell.TH
import System.Directory
import System.FilePath

import Web.Apiary
import Web.Apiary.Logger
import Network.Wai.Handler.Warp
import qualified Data.ByteString as S

cdThisDirectory :: IO ()
cdThisDirectory = setCurrentDirectory $(location >>= stringE . takeDirectory . loc_filename)

main :: IO ()
main =  do
  cdThisDirectory
  runApiaryWith (run 3000) (initLogger def) def $ do

                                    {-~~~~~~~~~~~~~~~~-}
                                    {-use logger extension-}

    method GET $ do
      root . action $ do
        contentType "text/html"
        logging "root has been accessed.\n"

        -- FIXME: better directory structure
        file "index.html" Nothing

    [capture|/temperatures|] $ do

      method POST $ do
        accept "application/json"
          . ([key|feeling|] =:  pInt)
          . ([key|place|]   =:  pInt)
          . document "store effective temperature by user"
          . action $ do
            contentType "application/json"
            logging "text page is accessed.\n"
            undefined

      method GET $ do
        accept "application/json"
          . document "view effective temperature map"
          . action $ do
            contentType "application/json"
            logging "text page is accessed.\n"
            undefined

    [capture|/api|] . document "api documentation" . action $ do
      logging "api documentation page is accessed.\n"
      defaultDocumentationAction def

      {-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-}
      {-auto generated api documentation action.-}


listEffectiveTemperatureLogs :: ActionT exts prms IO ()
listEffectiveTemperatureLogs = undefined


helloAction :: Members ["first" := S.ByteString, "last" := Maybe S.ByteString] prms

                 {-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-}
                 {-prms must have "first" :: S.ByteString-}
                 {-and "last" :: Maybe S.ByteString parameters.-}



            => ActionT exts prms IO ()
helloAction = do
  (f, l) <- [params|first, last|]

              {-~~~~~~~~~~~~~~~~~~~~-}
              {-get parameters. equals to `do { f <- param [key|first|];-}
                                              {-l <- param [key|last|] }`-}



  appendBytes "Hello, "
  appendBytes f
  maybe (return ()) (\a -> appendChar ' ' >> appendBytes a) l
