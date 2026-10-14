#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl gawk gnused coreutils
# Bump package.nix to the newest audirvana-studio in Audirvana's apt repo.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

index=https://audirvana.com/delivery/linux/apt-repo/dists/stable/non-free/binary-amd64/Packages

# Print "<version> <sha256>" for every audirvana-studio entry, keep the newest.
read -r version sha256 < <(
  curl -fsSL "$index" |
    awk '/^Package:/ { pkg = $2 } pkg == "audirvana-studio" && /^Version:/ { v = $2 }
         pkg == "audirvana-studio" && /^SHA256:/ { print v, $2 }' |
    sort -V | tail -n1
)

current=$(sed -n 's/^  version = "\(.*\)";/\1/p' package.nix)
if [[ "$version" == "$current" ]]; then
  echo "audirvana-studio is up to date ($current)"
  exit 0
fi

hash=$(nix hash convert --hash-algo sha256 --to sri "$sha256")
sed -i \
  -e "s|^  version = \".*\";|  version = \"$version\";|" \
  -e "s|^    hash = \".*\";|    hash = \"$hash\";|" \
  package.nix
echo "audirvana-studio: $current -> $version"
