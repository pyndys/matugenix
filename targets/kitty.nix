{ config, lib, ... }:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.kitty;
  template = cfg.internal.templates.kitty;
  auto = cfg.targets.autoTerminalColors;
in
{

  options.programs.matugen.targets.kitty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };
    terminalColors = lib.mkOption {
      type = lib.types.enum (lib.attrNames template);
      default = if template ? ${auto} then auto else "matugen";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.kitty.enable) {
    programs.matugen.settings.templates.kitty = {
      input_path = template.${targetCfg.terminalColors};
      output_path = "${config.xdg.configHome}/kitty/matugenix.conf";
    };

    programs.kitty.settings.include = "matugenix.conf";
  };
}
