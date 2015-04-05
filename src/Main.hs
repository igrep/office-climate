{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}

module Main where

import Web.Apiary
import Web.Apiary.Logger
import Network.Wai.Handler.Warp
import qualified Data.ByteString as S

main :: IO ()
main = runApiaryWith (run 3000) (initLogger def) def $ do

                                  {-~~~~~~~~~~~~~~~~-}
                                  {-use logger extension-}



  [capture|/temperatures|]

    . method POST $ do
      accept "application/json"
        . ([key|feeling|] =:  pInt)
        . ([key|place|]   =:  pInt)
        . document "store effective temperature by user"
        . action $ do
          logging "text page is accessed.\n"
          helloAction

    . method GET $ do
      accept "application/json"
        . document "view effective temperature map"
        . action $ do
          logging "text page is accessed.\n"
          helloAction

  [capture|/api|] . document "api documentation" . action $ do
    logging "api documentation page is accessed.\n"
    defaultDocumentationAction def

    {-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-}
    {-auto generated api documentation action.-}




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
