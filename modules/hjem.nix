{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.matugen;
in
{
  imports = [ ./options.nix ];

  config = lib.mkIf cfg.enable {
    packages = [ cfg.package ];
    xdg.config.files."matugen/config.toml" = lib.mkIf (cfg.settings != { }) {
      source = (pkgs.formats.toml { }).generate "matugen-nix.toml" ({ config = { }; } // cfg.settings);
    };
  };
}
