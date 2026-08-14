{
  config,
  lib,
  matugen-themes,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.equibop;
in
{
  options.programs.matugen.targets.equibop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };

    themeVariant = lib.mkOption {
      type = lib.types.enum [
        "midnight"
        "system24"
      ];
      default = "midnight";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.equibop.enable) {
    programs.matugen.settings.templates.equibop = {
      input_path =
        if targetCfg.themeVariant == "midnight" then
          "${matugen-themes}/templates/midnight-discord.css"
        else
          "${matugen-themes}/templates/system24.css";

      output_path = "${config.xdg.configHome}/equibop/themes/matugenix.css";
    };

    programs.equibop.equicord.settings.enabledThemes = [ "matugenix.css" ];
  };
}
