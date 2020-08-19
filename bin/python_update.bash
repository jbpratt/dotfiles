#!/usr/bin/env bash

set -e

declare -a branches=("master" "3.9" "3.7")

cd $HOME/cpython
git fetch

for branch in ${branches[@]}; do
  git checkout "${branch}"
  ./configure && make && make test
  sudo make install
done
