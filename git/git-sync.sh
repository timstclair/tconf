#!/bin/sh -e

REMOTE=${1:-upstream}
BRANCH=${2:-master}

git fetch $REMOTE
git rebase $REMOTE/$BRANCH
