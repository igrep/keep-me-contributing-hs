{-# LANGUAGE DeriveDataTypeable #-}

module KeepMeContributingHs
  ( OwnerName
  , RepositoryName
  , getLatestCommitDateFor
  ) where


import           Control.Exception
import           Data.String
import           Data.Time.LocalTime
import           Data.Typeable
import           Java
import           Java.Exception

import           KeepMeContributingHs.Date
import           KeepMeContributingHs.Github


type OwnerName = String

type RepositoryName = String

data GithubException =
  EmptyCommits | NoRepositoryOwner | OtherException JException deriving (Show, Typeable)

instance Exception GithubException

getLatestCommitDateFor :: OwnerName -> RepositoryName -> IO (Either GithubException ZonedTime)
getLatestCommitDateFor o r =
  (mapLeft OtherException) <$> try (java action)
  where
    action = do
      mbgr <- connectAnonymously >- getUser o >- getRepository (fromString r)
      case mbgr of
          Just gr -> do
            itr <- gr <.> listCommits >- iterator
            hn <- itr <.> hasNext
            if hn
              then itr <.> next >- getCommitDate >>= javaDateToZonedTime
              else io $ throwIO EmptyCommits
          _ -> io $ throwIO NoRepositoryOwner


mapLeft :: (a -> c) -> Either a b -> Either c b
mapLeft f (Left x)  = Left (f x)
mapLeft _ (Right x) = Right x
