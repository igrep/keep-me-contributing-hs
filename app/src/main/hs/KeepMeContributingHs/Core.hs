{-# LANGUAGE RecordWildCards #-}

module KeepMeContributingHs.Core where


import           Control.Exception
import           Control.Monad.Except
import           Data.Time.LocalTime
import           Data.Typeable


type OwnerName = String

type RepositoryName = String

type SerializedTime = String

data Env m =
  Env
    { getLatestCommitDateFor :: OwnerName -> RepositoryName -> ExceptT AppException m (ZonedTime)
    , getCurrentTime :: m ZonedTime
    , retrieveLastResult :: ExceptT AppException m (Maybe SerializedTime)
    , saveLastResult :: SerializedTime -> ExceptT AppException m ()
    , logError :: String -> m ()
    }

data AppException =
  EmptyCommits | NoRepositoryOwner | OtherException SomeException deriving (Show, Typeable)

instance Exception AppException


hasContributedToday :: Monad m => Env m -> OwnerName -> RepositoryName -> m Bool
hasContributedToday Env {..} _o _r =
  error "hasContributedToday is not defined yet!"


serializeTime :: ZonedTime -> SerializedTime
serializeTime =
  error "serializeTime is not defined yet!"


deserializeTime :: SerializedTime -> ZonedTime
deserializeTime =
  error "deserializeTime is not defined yet!"
