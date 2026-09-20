#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash git nix nix-update cacert
# Updates qtbridge-csharp to the latest tag on code.qt.io.
#
# nix-update can't discover new versions for arbitrary git hosts, so we ask
# git for the tags ourselves and pass the newest one to nix-update, which
# handles the version bump and the source/nuget hashes.
set -euo pipefail

# The updater runs this with the repository as the working directory, but when
# the flake is a store copy $0 no longer points inside the checkout, so find
# the root by walking up to flake.nix.
while [[ $PWD != / && ! -e flake.nix ]]; do cd ..; done
[[ -e flake.nix ]] || {
  echo "error: flake.nix not found; run this from the nixos repository" >&2
  exit 1
}

url="https://code.qt.io/qt/qtbridge-csharp.git"

version="$(
  git ls-remote --tags --refs "$url" |
    awk -F/ '{print $NF}' |
    grep -E '^[0-9]' |
    sort -V |
    tail -n1
)"

echo "latest qtbridge-csharp version: $version"

nix-update --flake --version="$version" qtbridge-csharp
