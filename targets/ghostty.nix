{
  config,
  lib,
  matugen-themes,
  dms,
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
    dank16 = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoDank16;
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.ghostty.enable) {
    programs.matugen.settings.templates.ghostty = {
      input_path =
        if targetCfg.dank16 then
          "${dms}/quickshell/matugen/templates/ghostty.conf"
        else
          "${matugen-themes}/templates/ghostty";
      output_path = "${config.xdg.configHome}/ghostty/themes/matugenix";
    };

    programs.ghostty.settings.theme = "matugenix";
  };
}
