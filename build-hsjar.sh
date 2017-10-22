#!/bin/sh

set -xue

(
  cd hs
  etlas new-build
)
cp "$(find ./hs -name 'eta-first.jar')" app/libs/
