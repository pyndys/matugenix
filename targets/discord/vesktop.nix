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
        "dms"
        "noctalia-midnight"
        "noctalia-material"
        "noctalia-system24"
      ];
      default = "midnight";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.vesktop.enable) {
    programs.matugen.settings.templates.vesktop = {
      input_path =
        {
          midnight = "${matugen-themes}/midnight-discord.css";
          system24 = "${matugen-themes}/system24.css";
          dms = "${dms}/vesktop.css";
          noctalia-midnight = "${noctalia-community}/discord/discord-midnight.css";
          noctalia-material = "${noctalia-community}/discord/discord-material.css";
          noctalia-system24 = "${noctalia-community}/discord/discord-system24.css";
        }
        .${targetCfg.themeVariant};
      output_path = "${config.xdg.configHome}/vesktop/themes/matugenix.css";
    };

    programs.vesktop.vencord.settings.enabledThemes = [ "matugenix.css" ];
  };
}
