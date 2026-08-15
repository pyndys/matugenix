{
  config,
  lib,
  matugen-themes,
  dms,
  noctalia-community,
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
        "dms"
        "noctalia-midnight"
        "noctalia-material"
        "noctalia-system24"
      ];
      default = "midnight";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.equibop.enable) {
    programs.matugen.settings.templates.equibop = {
      input_path =
        {
          midnight = "${matugen-themes}/templates/midnight-discord.css";
          system24 = "${matugen-themes}/templates/system24.css";
          dms = "${dms}/quickshell/matugen/templates/vesktop.css";
          noctalia-midnight = "${noctalia-community}/discord/discord-midnight.css";
          noctalia-material = "${noctalia-community}/discord/discord-material.css";
          noctalia-system24 = "${noctalia-community}/discord/discord-system24.css";
        }
        .${targetCfg.themeVariant};
      output_path = "${config.xdg.configHome}/equibop/themes/matugenix.css";
    };

    programs.equibop.equicord.settings.enabledThemes = [ "matugenix.css" ];
  };
}
