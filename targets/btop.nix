{
  config,
  lib,
  matugen-themes,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.btop;
in
{
  options.programs.matugen.targets.btop.enable = lib.mkOption {
    type = lib.types.bool;
    default = cfg.targets.autoEnable;
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.btop.enable) {
    programs.matugen.settings.templates.btop = {
      input_path = "${matugen-themes}/btop.theme";
      output_path = "${config.xdg.configHome}/btop/themes/matugenix.theme";
      post_hook = "pkill -USR2 btop || true";
    };

    programs.btop.settings.color_theme = "matugenix";
  };
}
