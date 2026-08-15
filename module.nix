{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.matugen;
  format = pkgs.formats.toml { };
  settings = {
    config = { };
  }
  // cfg.settings;
in
{
  imports = [ ./targets ];

  options.programs.matugen = {
    enable = lib.mkEnableOption "enable matugen";
    package = lib.mkPackageOption pkgs "matugen" { };

    targets = {
      autoEnable = lib.mkEnableOption "Auto enable targets";
      autoTerminalColors = lib.mkOption {
        type = lib.types.enum [
          "matugen"
          "dank16"
          "noctalia"
        ];
        default = "matugen";
      };
    };

    settings = lib.mkOption {
      type = format.type;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."matugen/config.toml" = lib.mkIf (cfg.settings != { }) {
      source = format.generate "matugenix-config.toml" settings;
    };
  };
}
