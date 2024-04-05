#!/bin/bash

set -eu

# usage
if [ $# -ne 1 ]; then
    echo "usage: $0 <email regey>"
    exit -1
fi

# https://github.com/orgs/community/discussions/89886#discussioncomment-8650093
git log --author=$1 --pretty=tformat: --numstat | awk '{ adds += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s, added:deleted ratio:%s\n", adds, subs, loc, adds/subs }' -

