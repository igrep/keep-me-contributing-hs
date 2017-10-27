{-# LANGUAGE DataKinds #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Java

-- Dummy main function to make uber jar in Eta
main :: IO ()
main = putStrLn "Hello, Etlas!"


foreign export java "@static android.appwidget.AppWidgetProviderHs.onUpdate"
  onWidgetUpdate :: JIntArray -> Java a ()

onWidgetUpdate :: JIntArray -> Java a ()
onWidgetUpdate _is = return ()
