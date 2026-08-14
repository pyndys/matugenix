{
  config,
  lib,
  matugen-themes,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.vesktop;
in
{
  options.programs.matugen.targets.vesktop = {
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

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.vesktop.enable) {
    programs.matugen.settings.templates.vesktop = {
      input_path =
        if targetCfg.themeVariant == "midnight" then
          "${matugen-themes}/templates/midnight-discord.css"
        else
          "${matugen-themes}/templates/system24.css";

      output_path = "${config.xdg.configHome}/vesktop/themes/matugenix.css";
    };

    programs.vesktop.vencord.settings.enabledThemes = [ "matugenix.css" ];
  };
}
