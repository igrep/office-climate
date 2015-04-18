{-# LANGUAGE TemplateHaskell #-}

module OfficeClimate.DeriveJSON where

import OfficeClimate.User (User)
import OfficeClimate.Place (Place)
import OfficeClimate.TemperatureReport (TemperatureReport)

import Data.Aeson.TH (deriveJSON, defaultOptions)

$(deriveJSON defaultOptions ''Place)
$(deriveJSON defaultOptions ''TemperatureReport)
$(deriveJSON defaultOptions ''User)
