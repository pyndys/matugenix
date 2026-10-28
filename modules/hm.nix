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
    home.packages = [ cfg.package ];
    xdg.configFile."matugen/config.toml" = lib.mkIf (cfg.settings != { }) {
      source = (pkgs.formats.toml { }).generate "matugen-nix.toml" ({ config = { }; } // cfg.settings);
    };
  };
}
