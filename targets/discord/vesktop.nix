{ config, lib, ... }:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.vesktop;
  template = cfg.internal.templates.discord;
in
{
  options.programs.matugen.targets.vesktop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };

    themeVariant = lib.mkOption {
      type = lib.types.enum (lib.attrNames template);
      default = "midnight";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.vesktop.enable) {
    programs.matugen.settings.templates.vesktop = {
      input_path = template.${targetCfg.themeVariant};
      output_path = "${config.xdg.configHome}/vesktop/themes/matugenix.css";
    };

    programs.vesktop.vencord.settings.enabledThemes = [ "matugenix.css" ];
  };
}
