{ config, lib, ... }:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.equibop;
  template = cfg.internal.templates.discord;
in
{
  options.programs.matugen.targets.equibop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };

    themeVariant = lib.mkOption {
      type = lib.types.enum (lib.attrNames template);
      default = "midnight";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.equibop.enable) {
    programs.matugen.settings.templates.equibop = {
      input_path = template.${targetCfg.themeVariant};
      output_path = "${config.xdg.configHome}/equibop/themes/matugenix.css";
    };

    programs.equibop.equicord.settings.enabledThemes = [ "matugenix.css" ];
  };
}
