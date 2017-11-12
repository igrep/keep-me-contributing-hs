module KeepMeContributingHs.Android
  ( getLatestCommitDateFor
  , module KeepMeContributingHs.Android.Date
  ) where


import           Control.Exception
import           Data.String
import           Data.Time.LocalTime
import           Java

import           KeepMeContributingHs.Core hiding (getLatestCommitDateFor)
import           KeepMeContributingHs.Android.Date
import           KeepMeContributingHs.Android.Github


getLatestCommitDateFor :: OwnerName -> RepositoryName -> IO (Either AppException ZonedTime)
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
