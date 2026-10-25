{ config, lib, ... }:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.foot;
  template = cfg.internal.templates.foot;
  auto = cfg.targets.autoTerminalColors;
in
{

  options.programs.matugen.targets.foot = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };
    terminalColors = lib.mkOption {
      type = lib.types.enum (lib.attrNames template);
      default = if template ? ${auto} then auto else "matugen";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.foot.enable) {
    programs.matugen.settings.templates.foot = {
      input_path = template.${targetCfg.terminalColors};
      output_path = "${config.xdg.configHome}/foot/matugenix.ini";
      post_hook = "pkill -SIGUSR1 foot";
    };

    programs.foot.settings.main.include = cfg.settings.templates.foot.output_path;
  };
}
