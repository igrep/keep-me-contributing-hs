{-# LANGUAGE DataKinds #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}

module KeepMeContributingHs.Github where

import Java
import Java.DateTime


data PagedIterable a = PagedIterable (@org.kohsuke.github.PagedIterable a) deriving Class
type instance Inherits (PagedIterable a) = '[Iterable a]


data GitHub = GitHub @org.kohsuke.github.GitHub deriving Class

foreign import java unsafe "@static org.kohsuke.github.GitHub.connectAnonymously"
  connectAnonymously :: Java a GitHub

foreign import java unsafe getUser :: String -> Java GitHub GHUser


data GHCommit = GHCommit @org.kohsuke.github.GHCommit deriving Class

foreign import java unsafe getCommitDate :: Java GHCommit Date


data GHObject = GHObject @org.kohsuke.github.GHObject deriving Class

data GHPerson = GHPerson @org.kohsuke.github.GHPerson deriving Class
type instance Inherits GHPerson = '[GHObject]

foreign import java unsafe getRepository :: (o <: GHPerson) => JString -> Java o (Maybe GHRepository)


data GHUser = GHUser @org.kohsuke.github.GHUser deriving Class
type instance Inherits GHUser = '[GHPerson]

data GHRepository = GHRepository @org.kohsuke.github.GHRepository deriving Class
type instance Inherits GHRepository = '[GHObject]

foreign import java unsafe listCommits :: Java GHRepository (PagedIterable GHCommit)
