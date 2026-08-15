{
  config,
  lib,
  matugen-themes,
  dms,
  noctalia,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.alacritty;
in
{

  options.programs.matugen.targets.alacritty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };
    terminalColors = lib.mkOption {
      type = lib.types.enum [
        "matugen"
        "dank16"
        "noctalia"
      ];
      default = cfg.targets.autoTerminalColors;
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.alacritty.enable) {
    programs.matugen.settings.templates.alacritty = {
      input_path =
        {
          matugen = "${matugen-themes}/templates/alacritty.toml";
          dank16 = "${dms}/quickshell/matugen/templates/alacritty.toml";
          noctalia = "${noctalia}/assets/templates/alacritty/alacritty.toml";
        }
        .${targetCfg.terminalColors};
      output_path = "${config.xdg.configHome}/alacritty/matugenix.toml";
    };

    programs.alacritty.settings.general.import = [ "matugenix.toml" ];
  };
}
