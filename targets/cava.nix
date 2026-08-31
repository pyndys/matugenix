{
  config,
  lib,
  matugen-themes,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.cava;
in
{
  options.programs.matugen.targets.cava.enable = lib.mkOption {
    type = lib.types.bool;
    default = cfg.targets.autoEnable;
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.cava.enable) {
    programs.matugen.settings.templates.cava = {
      input_path = "${matugen-themes}/cava-colors.ini";
      output_path = "${config.xdg.configHome}/cava/themes/matugenix.ini";
      post_hook = "pkill -USR1 cava";
    };

    programs.cava.settings.color.theme = "matugenix.ini";
  };
}
