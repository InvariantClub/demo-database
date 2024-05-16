#!/usr/bin/env bash


set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "error: Please call with one arg; the commit to view."
  echo ""
  echo "  i.e.: ./compute-demo-diff.sh <commit-hash>"
  echo ""
  echo "Here's the commits you can pick from:"
  echo ""
  git log --oneline
  exit 1
fi

commit="$1"

temp_dir=$(mktemp -d)

git clone . $temp_dir>/dev/null 2>&1

cd $temp_dir && git checkout $commit>/dev/null 2>&1

# Mount the tmp dir and run metadelta via the cli
EXE="docker run -i -v $temp_dir:/work ghcr.io/invariantclub/metadelta"

${EXE} single \
  -p /work/hasura/metadata \
  --label $commit
