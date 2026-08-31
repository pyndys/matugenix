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
  targetCfg = cfg.targets.foot;
in
{

  options.programs.matugen.targets.foot = {
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

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.foot.enable) {
    programs.matugen.settings.templates.foot = {
      input_path =
        {
          matugen = "${matugen-themes}/templates/foot-colors.ini";
          dank16 = "${dms}/quickshell/matugen/templates/foot.ini";
          noctalia = "${noctalia}/assets/templates/foot/foot";
        }
        .${targetCfg.terminalColors};
      output_path = "${config.xdg.configHome}/foot/matugenix.ini";
      post_hook = "pkill -SIGUSR1 foot";
    };

    programs.foot.settings.main.include = cfg.settings.templates.foot.output_path;
  };
}
