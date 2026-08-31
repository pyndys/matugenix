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
  targetCfg = cfg.targets.kitty;
in
{

  options.programs.matugen.targets.kitty = {
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

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.kitty.enable) {
    programs.matugen.settings.templates.kitty = {
      input_path =
        {
          matugen = "${matugen-themes}/kitty-colors.conf";
          dank16 = "${dms}/kitty.conf";
          noctalia = "${noctalia}/kitty/kitty.conf";
        }
        .${targetCfg.terminalColors};
      output_path = "${config.xdg.configHome}/kitty/matugenix.conf";
    };

    programs.kitty.settings.include = "matugenix.conf";
  };
}
