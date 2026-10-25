#!/usr/bin/env bash
# Refuses a deploy unless what's on disk is a commit on GitHub's main, so what's
# live is always one. The same file in every site repo; the rule and the list
# of sites are in Workshop's Tooling/deploy.md.
#
#   scripts/deploy-guard.sh                # a Worker: main must equal origin/main
#   scripts/deploy-guard.sh --allow-ahead  # Workers Builds: the push is the deploy
set -euo pipefail

refuse() {
  echo "Deploy refused: $*" >&2
  exit 1
}

branch=$(git branch --show-current)
[[ $branch == main ]] || refuse "on ${branch:-a detached HEAD}, not main."
[[ -z $(git status --porcelain) ]] || refuse "uncommitted or untracked files."
git fetch --quiet origin main || refuse "can't fetch origin/main."
behind=$(git rev-list --count main..origin/main)
ahead=$(git rev-list --count origin/main..main)
((behind == 0)) || refuse "main is behind origin/main by $behind. Pull first."
((ahead == 0)) || [[ ${1:-} == --allow-ahead ]] ||
  refuse "main is ahead of origin/main by $ahead. Land it through a PR first."
