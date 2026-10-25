{ config, lib, ... }:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.ghostty;
  template = cfg.internal.templates.ghostty;
  auto = cfg.targets.autoTerminalColors;
in
{
  options.programs.matugen.targets.ghostty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };
    terminalColors = lib.mkOption {
      type = lib.types.enum (lib.attrNames template);
      default = if template ? ${auto} then auto else "matugen";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.ghostty.enable) {
    programs.matugen.settings.templates.ghostty = {
      input_path = template.${targetCfg.terminalColors};
      output_path = "${config.xdg.configHome}/ghostty/themes/matugenix";
      post_hook = "pkill -SIGUSR2 ghostty";
    };

    programs.ghostty.settings.theme = "matugenix";
  };
}
