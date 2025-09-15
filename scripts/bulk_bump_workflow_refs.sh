#!/usr/bin/env bash
set -euo pipefail
if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <tag> <repos.txt>" >&2
  exit 1
fi
TAG="$1"; LIST="$2"
while IFS= read -r repo; do
  [[ -z "$repo" ]] && continue
  TMP=$(mktemp -d)
  pushd "$TMP" >/dev/null
  gh repo clone "$repo" .
  git switch -c "ci/bump-governance-ci-$TAG"
  sed -i "s#\(vo2-governance/.github/workflows/reusable-ci.yml@\).*#\1$TAG#" .github/workflows/ci.yml || true
  git add .github/workflows/ci.yml || true
  if git commit -m "ci(governance): bump reusable CI to $TAG"; then
    git push -u origin HEAD
    gh pr create --title "ci(governance): bump reusable CI to $TAG" --body "Update reusable governance CI ref to $TAG." || true
  fi
  popd >/dev/null
  rm -rf "$TMP"
done < "$LIST"
