{
  config,
  lib,
  options,
  matugen-themes,
  dms,
  noctalia-community,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.nixcord;

  hasNixcord = options ? programs.nixcord;

  nixcordCfg = if hasNixcord then config.programs.nixcord else { };

  nixcordEnabled = nixcordCfg.enable or false;
  discordEnabled = lib.attrByPath [ "discord" "enable" ] false nixcordCfg;
  vencordEnabled = lib.attrByPath [ "discord" "vencord" "enable" ] false nixcordCfg;
  equicordEnabled = lib.attrByPath [ "discord" "equicord" "enable" ] false nixcordCfg;
  vesktopEnabled = lib.attrByPath [ "vesktop" "enable" ] false nixcordCfg;
  equibopEnabled = lib.attrByPath [ "equibop" "enable" ] false nixcordCfg;

  chosenThemeVariant =
    {
      midnight = "${matugen-themes}/midnight-discord.css";
      system24 = "${matugen-themes}/system24.css";
      dms = "${dms}/vesktop.css";
      noctalia-midnight = "${noctalia-community}/discord/discord-midnight.css";
      noctalia-material = "${noctalia-community}/discord/discord-material.css";
      noctalia-system24 = "${noctalia-community}/discord/discord-system24.css";
    }
    .${targetCfg.themeVariant};
in
{
  options.programs.matugen.targets.nixcord = {
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

  config = lib.mkIf (cfg.enable && targetCfg.enable && nixcordEnabled) (
    lib.mkMerge [
      (lib.mkIf (vencordEnabled && discordEnabled) {
        programs.matugen.settings.templates.nixcord-vencord = {
          input_path = chosenThemeVariant;
          output_path = "${config.xdg.configHome}/Vencord/themes/matugenix.css";
        };
      })
      (lib.mkIf (equicordEnabled && discordEnabled) {
        programs.matugen.settings.templates.nixcord-equicord = {
          input_path = chosenThemeVariant;
          output_path = "${config.xdg.configHome}/Equicord/themes/matugenix.css";
        };
      })
      (lib.mkIf vesktopEnabled {
        programs.matugen.settings.templates.nixcord-vesktop = {
          input_path = chosenThemeVariant;
          output_path = "${config.xdg.configHome}/vesktop/themes/matugenix.css";
        };
      })
      (lib.mkIf equibopEnabled {
        programs.matugen.settings.templates.nixcord-equibop = {
          input_path = chosenThemeVariant;
          output_path = "${config.xdg.configHome}/equibop/themes/matugenix.css";
        };
      })
      (lib.optionalAttrs hasNixcord {
        programs.nixcord.config.enabledThemes = [ "matugenix.css" ];
      })
    ]
  );
}
