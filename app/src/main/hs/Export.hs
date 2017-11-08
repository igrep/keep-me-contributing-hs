{-# LANGUAGE DataKinds #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Java
import Java.StringUtils as S

import Test.Hspec

import qualified KeepMeContributingHs
import qualified KeepMeContributingHs.Date


-- Dummy main function to make uber jar in Eta
main :: IO ()
main = hspec $
  describe "KeepMeContributingHs.Date.getCurrentTime" $ do
    it "can get current time without error" $
      print =<< KeepMeContributingHs.Date.getCurrentTime

    it "can get latest commit time without error" $
      print =<< KeepMeContributingHs.getLatestCommitDateFor "igrep" "daily-commits"

-- do
--   print =<< KeepMeContributingHs.getLatestCommitDateFor "igrep" "daily-commits"
--   print =<< KeepMeContributingHs.Date.getCurrentTime


foreign export java "@static info.igreque.KeepMeContributingWidgetProviderHs.spec"
  spec :: Java a ()

spec :: Java a ()
spec = io $ hspec $
  describe "KeepMeContributingHs.Date.getCurrentTime" $ do
    it "can get current time without error" $
      print =<< KeepMeContributingHs.Date.getCurrentTime

    it "can get latest commit time without error" $
      print =<< KeepMeContributingHs.getLatestCommitDateFor "igrep" "daily-commits"


data Context = Context @android.content.Context deriving Class


data Activity = Activity @android.app.Activity deriving Class


type instance Inherits Activity = '[Context]

data View = View @android.view.View deriving Class


data ImageView = ImageView @android.widget.ImageView deriving Class

type instance Inherits ImageView = '[View]


data TextView = TextView @android.widget.TextView deriving Class

type instance Inherits TextView = '[View]


data Toast = Toast @android.widget.Toast deriving Class


data AppWidgetManager = AppWidgetManager @android.appwidget.AppWidgetManager deriving Class


data AppWidgetProvider = AppWidgetProvider @android.appwidget.AppWidgetProvider deriving Class


foreign import java unsafe "setContentView"
  setContentView :: (v <: View) => v -> Java Activity ()


foreign import java unsafe "@new"
  newTextView :: (c <: Context) => c -> Java a TextView


foreign import java unsafe "setText"
  setText :: (c <: CharSequence) => c -> Java TextView ()


foreign import java unsafe "@static android.widget.Toast.makeText"
  makeText :: (c <: CharSequence) => Context -> c -> Int -> Java a Toast


foreign import java unsafe "show"
  showToast :: Java Toast ()


foreign import java unsafe "@static @field android.widget.Toast.LENGTH_LONG"
  c_TOAST_LONG :: Int


foreign export java "@static info.igreque.android.ActivityImpl.startActivity"
  startActivity :: Activity -> Java a ()

startActivity :: Activity -> Java a ()
startActivity activity = do
  textView <- newTextView activity
  textView <.> setText (foldr S.concat "World!" (replicate 10 "Eta "))
  activity <.> setContentView textView


foreign export java "@static info.igreque.keepmecontributinghs.KeepMeContributingWidgetProviderHs.onUpdate"
  onWidgetUpdate :: Context -> AppWidgetManager -> JIntArray -> Java a ()

onWidgetUpdate :: Context -> AppWidgetManager -> JIntArray -> Java a ()
onWidgetUpdate c _w _is = do
  toast <- makeText c ("Hello, Widget written in Eta!"  :: JString) c_TOAST_LONG
  toast <.> showToast
