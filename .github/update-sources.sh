#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
file=templates/sources.json
fake=$(nix eval --raw --impure --expr '(import <nixpkgs> { }).lib.fakeHash')

names=("$@")
if [ ${#names[@]} -eq 0 ]; then
  mapfile -t names < <(jq -r 'keys[]' "$file")
fi

edit() { jq "$1" "$file" > "$file.tmp" && mv "$file.tmp" "$file"; }

for name in "${names[@]}"; do
  owner=$(jq -r --arg n "$name" '.[$n].owner' "$file")
  repo=$(jq -r --arg n "$name" '.[$n].repo' "$file")
  old=$(jq -r --arg n "$name" '.[$n].rev' "$file")
  new=$(git ls-remote "https://github.com/$owner/$repo" HEAD | cut -f1)
  if [ "$old" = "$new" ]; then echo "$name: no changes"; continue; fi
  
  edit ".\"$name\".rev = \"$new\" | .\"$name\".hash = \"$fake\""
  out=$(nix build --no-link --impure --expr "
    let pkgs = import <nixpkgs> { };
    in (import ./templates/sources.nix { inherit pkgs; }).\"$name\"" 2>&1 || true)
    
  got=$(grep -oE 'got: +sha256-[A-Za-z0-9+/=]+' <<<"$out" | awk '{print $2}' | head -1)
  
  if [ -z "$got" ]; then echo "$out"; echo "dont get hash for $name"; exit 1; fi
  
  edit ".\"$name\".hash = \"$got\""
  echo "$name: $old -> $new"
done
