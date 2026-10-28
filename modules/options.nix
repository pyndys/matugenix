{ lib, pkgs, ... }:
{
  options.programs.matugen = {
    enable = lib.mkEnableOption "matugen";
    package = lib.mkPackageOption pkgs "matugen" { };
    settings = lib.mkOption {
      type = (pkgs.formats.toml { }).type;
      default = { };
    };
  };
}
