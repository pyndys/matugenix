{ config, lib, ... }:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.helix;
  template = cfg.internal.templates.helix;
in
{
  options.programs.matugen.targets.helix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };
    themeVariant = lib.mkOption {
      type = lib.types.enum (lib.attrNames template);
      default = "matugen";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.helix.enable) {
    programs.matugen.settings.templates.helix = {
      input_path = template.${targetCfg.themeVariant};
      output_path = "${config.xdg.configHome}/helix/themes/matugenix.toml";
    };

    programs.helix.settings.theme = "matugenix";
  };
}
