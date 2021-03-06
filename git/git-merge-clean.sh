#!/bin/bash

set -euf -o pipefail

git branch --merged | grep -v '\*' | grep -v master | grep -v dev | xargs -n 1 git branch -d
