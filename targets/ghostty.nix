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
  targetCfg = cfg.targets.ghostty;
in
{
  options.programs.matugen.targets.ghostty = {
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

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.ghostty.enable) {
    programs.matugen.settings.templates.ghostty = {
      input_path =
        {
          matugen = "${matugen-themes}/templates/ghostty";
          dank16 = "${dms}/quickshell/matugen/templates/ghostty.conf";
          noctalia = "${noctalia}/assets/templates/ghostty/ghostty";
        }
        .${targetCfg.terminalColors};
      output_path = "${config.xdg.configHome}/ghostty/themes/matugenix";
    };

    programs.ghostty.settings.theme = "matugenix";
  };
}
