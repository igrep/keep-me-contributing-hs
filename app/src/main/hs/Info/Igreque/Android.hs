{-# LANGUAGE DataKinds #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Java
import Java.StringUtils as S

import qualified KeepMeContributingHs


-- Dummy main function to make uber jar in Eta
main :: IO ()
main = print =<< getLatestCommitFor "igrep" "daily-commits"
-- main = putStrLn "Hello, eta!"


data {-# CLASS "android.content.Context" #-}
  Context = Context (Object# Context) deriving Class


data {-# CLASS "android.app.Activity" #-}
  Activity = Activity (Object# Activity) deriving Class

type instance Inherits Activity = '[Context]


data {-# CLASS "android.view.View" #-}
  View = View (Object# View) deriving Class


data {-# CLASS "android.widget.ImageView" #-}
  ImageView = ImageView (Object# ImageView) deriving Class

type instance Inherits ImageView = '[View]


data {-# CLASS "android.widget.TextView" #-}
  TextView = TextView (Object# TextView) deriving Class

type instance Inherits TextView = '[View]


data {-# CLASS "android.widget.Toast" #-}
  Toast = Toast (Object# Toast) deriving Class


data {-# CLASS "android.appwidget.AppWidgetManager" #-}
  AppWidgetManager = AppWidgetManager (Object# AppWidgetManager) deriving Class


data {-# CLASS "android.appwidget.AppWidgetProvider" #-}
  AppWidgetProvider = AppWidgetProvider (Object# AppWidgetProvider) deriving Class

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


data {-# CLASS "info.igreque.android.ActivityImpl" #-}
  ActivityImpl = ActivityImpl (Object# ActivityImpl)


foreign export java "@static startActivity"
  startActivity :: Activity -> Java ActivityImpl ()

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
