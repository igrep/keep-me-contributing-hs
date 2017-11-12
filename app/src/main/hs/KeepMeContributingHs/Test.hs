module KeepMeContributingHs.Test where

import           Control.Monad
import           Data.Time.LocalTime
import           Test.HUnit

import           KeepMeContributingHs.Core


runAllTests :: IO ()
runAllTests = void $ runTestTT
  ( test
     [ "When the last result is not saved yet" ~: test
          [ "and the latest commit date got from GitHub API is AFTER the begginning of today" ~: do
              print "a"
          , "and the latest commit date got from GitHub API is BEFORE the begginning of today" ~: do
              print "a"
          ]
     , "When the last result is BEFORE the begginning of today" ~: test
          [ "and the latest commit date got from GitHub API is AFTER the begginning of today" ~: do
              print "a"
          , "and the latest commit date got from GitHub API is BEFORE the begginning of today" ~: do
              print "a"
          ]
     , "When the last result is AFTER the begginning of today" ~: do
          time <- getZonedTime
          let now =
                time { zonedTimeToLocalTime = (zonedTimeToLocalTime time) { localTimeOfDay = midday } }
              committedAt = 
                time { zonedTimeToLocalTime = (zonedTimeToLocalTime time) { localTimeOfDay = dayFractionToTimeOfDay (9 / 24) } }
              env = Env
                { getLatestCommitDateFor = error "Don't call getLatestCommitDateFor"
                , getCurrentTime = return now
                , retrieveLastResult = return $ Just $ serializeTime committedAt
                , saveLastResult = error "Don't call saveLastResult"
                , logError = error "Don't call logError"
                }
          commited <- hasContributedToday env "owner" "repository"
          assertBool "returns True" commited
     ]
  )
