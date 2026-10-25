{ pkgs }:
let
  pins = builtins.fromJSON (builtins.readFile ./sources.json);
in
pkgs.lib.mapAttrs (
  _: p:
  pkgs.fetchFromGitHub (
    {
      inherit (p)
        owner
        repo
        rev
        hash
        ;
    }
    // pkgs.lib.optionalAttrs (p ? sparseCheckout) {
      inherit (p)
        sparseCheckout
        ;
    }
  )
) pins
