{ config, lib, ... }:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.alacritty;
  template = cfg.internal.templates.alacritty;
  auto = cfg.targets.autoTerminalColors;
in
{

  options.programs.matugen.targets.alacritty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };
    terminalColors = lib.mkOption {
      type = lib.types.enum (lib.attrNames template);
      default = if template ? ${auto} then auto else "matugen";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.alacritty.enable) {
    programs.matugen.settings.templates.alacritty = {
      input_path = template.${targetCfg.terminalColors};
      output_path = "${config.xdg.configHome}/alacritty/matugenix.toml";
    };

    programs.alacritty.settings.general.import = [ "matugenix.toml" ];
  };
}
