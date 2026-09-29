#!/usr/bin/env bash
# Says whether main is live, from the "Cloudflare Pages" check run that Pages
# puts on each commit it builds. See Workshop's Tooling/deploy.md.
#
#   scripts/pages-status.sh         # mise run deploy-status
#   scripts/pages-status.sh --wait  # after a push: wait until origin/main is live
set -euo pipefail

git fetch --quiet origin main
repo=$(gh repo view --json nameWithOwner --jq .nameWithOwner)
sha=$(git rev-parse origin/main)
short=${sha:0:7}

# "completed success", "completed failure", "in_progress null", or nothing
# before Pages has seen the commit.
build() {
  gh api "repos/$repo/commits/$sha/check-runs?check_name=Cloudflare%20Pages" \
    --jq '.check_runs[0] // empty | "\(.status) \(.conclusion)"'
}

if [[ ${1:-} == --wait ]]; then
  for _ in $(seq 60); do
    case $(build) in
      "completed success") echo "$short is live." && exit 0 ;;
      completed*) echo "Cloudflare Pages failed to build $short." >&2 && exit 1 ;;
    esac
    sleep 10
  done
  echo "Cloudflare Pages hasn't finished $short after 10 minutes." >&2
  exit 1
fi

ahead=$(git rev-list --count origin/main..main)
((ahead == 0)) || echo "main has $ahead commits not pushed, so not live."
case $(build) in
  "completed success") echo "origin/main ($short) is live." ;;
  completed*) echo "origin/main ($short) failed to build. An older commit is live." ;;
  "") echo "Cloudflare Pages hasn't built origin/main ($short)." ;;
  *) echo "origin/main ($short) is building." ;;
esac
