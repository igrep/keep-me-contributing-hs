{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}

module KeepMeContributingHs.Android.Date
  ( javaDateToZonedTime
  , getCurrentTime
  )
where

import           Java
import           Java.DateTime hiding (TimeZone)
import qualified Java.DateTime as Java

import           Data.Time.Calendar
import           Data.Time.Clock
import           Data.Time.LocalTime


foreign import java unsafe "@static java.util.Calendar.getInstance"
  getCalendar :: Java a Calendar

foreign import java unsafe "@static @field java.util.Calendar.YEAR"
  c_YEAR :: Int
foreign import java unsafe "@static @field java.util.Calendar.MONTH"
  c_MONTH :: Int
foreign import java unsafe "@static @field java.util.Calendar.DATE"
  c_DATE :: Int
foreign import java unsafe "@static @field java.util.Calendar.HOUR_OF_DAY"
  c_HOUR_OF_DAY :: Int
foreign import java unsafe "@static @field java.util.Calendar.MINUTE"
  c_MINUTE :: Int
foreign import java unsafe "@static @field java.util.Calendar.SECOND"
  c_SECOND :: Int


foreign import java unsafe "@static @field java.util.TimeZone.SHORT"
  c_TimeZone_SHORT :: Int


javaDateToZonedTime :: Date -> Java a ZonedTime
javaDateToZonedTime d = do
  c <- getCalendar
  c <.> setTime d
  y <- fromIntegral <$> c <.> get c_YEAR
  m <- (+1) <$> c <.> get c_MONTH
  day <- c <.> get c_DATE
  todHour <- c <.> get c_HOUR_OF_DAY
  todMin <- c <.> get c_MINUTE
  todSec <- fromIntegral <$> c <.> get c_SECOND
  z <- c <.> Java.getTimeZone
  -- FIXME: I'm not sure it correctly handles summer time
  timeZoneName <- z <.> getDisplayNameTimeZone2 False c_TimeZone_SHORT
  epochTime <- d <.> getTimeDate
  timeZoneMinutes <- (* 60) . (* 1000) <$> z <.> getOffset2 epochTime
  let localDay = fromGregorian y m day
      localTimeOfDay = TimeOfDay {..}
      timeZoneSummerOnly = False
      zonedTimeToLocalTime = LocalTime {..}
      zonedTimeZone = TimeZone {..}
  return ZonedTime {..}


begginingOfToday :: IO ZonedTime
begginingOfToday = do
  ZonedTime {..} <- getZonedTime
  return $
    ZonedTime
      (zonedTimeToLocalTime { localTimeOfDay = midnight })
      zonedTimeZone
