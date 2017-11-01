module KeepMeContributingHs
  ( getLatestCommitFor
  ) where


import           Data.Vector (!?)
import qualified GitHub
import qualified GitHub.Endpoints.Repos.Commits as GitHub


getLatestCommitFor :: GitHub.Name GitHub.Owner -> GitHub.Name GitHub.Repos -> IO (Either String GitHub.Commit)
getLatestCommitFor o r = do
  res <- GitHub.commitsFor o r
  return $
    case res of
        Right cs ->
          case cs !? 0 of
              Just a -> Right a
              _ -> Left "No commits found!"
        Left err -> Left $ show err
