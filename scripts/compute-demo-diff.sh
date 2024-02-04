#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "error: Please call with two args; the commits to compare."
  echo ""
  echo "  i.e.: ./compute-demo-diff.sh <old-commit-hash> <new-commit-hash>"
  echo ""
  echo "Here's the commits you can pick from:"
  echo ""
  git log --oneline
  exit 1
fi

old="$1"
new="$2"

temp_dir_old=$(mktemp -d)
temp_dir_new=$(mktemp -d)

this_dir=$(pwd)

git clone . $temp_dir_old>/dev/null 2>&1
git clone . $temp_dir_new>/dev/null 2>&1

cd $temp_dir_old && git checkout $old>/dev/null 2>&1
cd $temp_dir_new && git checkout $new>/dev/null 2>&1

EXE="docker run -it -v $temp_dir_old:/old -v $temp_dir_new:/new ghcr.io/invariantclub/metadelta-cli"

${EXE} diff \
  -o /old/hasura/metadata \
  --oldLabel $old \
  -n /new/hasura/metadata \
  --newLabel $new
