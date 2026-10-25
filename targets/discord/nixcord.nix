{
  config,
  lib,
  options,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.nixcord;
  template = cfg.internal.templates.discord;

  hasNixcord = options ? programs.nixcord;

  nixcordCfg = if hasNixcord then config.programs.nixcord else { };

  nixcordEnabled = nixcordCfg.enable or false;
  discordEnabled = lib.attrByPath [ "discord" "enable" ] false nixcordCfg;
  vencordEnabled = lib.attrByPath [ "discord" "vencord" "enable" ] false nixcordCfg;
  equicordEnabled = lib.attrByPath [ "discord" "equicord" "enable" ] false nixcordCfg;
  vesktopEnabled = lib.attrByPath [ "vesktop" "enable" ] false nixcordCfg;
  equibopEnabled = lib.attrByPath [ "equibop" "enable" ] false nixcordCfg;
in
{
  options.programs.matugen.targets.nixcord = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };

    themeVariant = lib.mkOption {
      type = lib.types.enum (lib.attrNames template);
      default = "midnight";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && nixcordEnabled) (
    lib.mkMerge [
      (lib.mkIf (vencordEnabled && discordEnabled) {
        programs.matugen.settings.templates.nixcord-vencord = {
          input_path = template.${targetCfg.themeVariant};
          output_path = "${config.xdg.configHome}/Vencord/themes/matugenix.css";
        };
      })
      (lib.mkIf (equicordEnabled && discordEnabled) {
        programs.matugen.settings.templates.nixcord-equicord = {
          input_path = template.${targetCfg.themeVariant};
          output_path = "${config.xdg.configHome}/Equicord/themes/matugenix.css";
        };
      })
      (lib.mkIf vesktopEnabled {
        programs.matugen.settings.templates.nixcord-vesktop = {
          input_path = template.${targetCfg.themeVariant};
          output_path = "${config.xdg.configHome}/vesktop/themes/matugenix.css";
        };
      })
      (lib.mkIf equibopEnabled {
        programs.matugen.settings.templates.nixcord-equibop = {
          input_path = template.${targetCfg.themeVariant};
          output_path = "${config.xdg.configHome}/equibop/themes/matugenix.css";
        };
      })
      (lib.optionalAttrs hasNixcord {
        programs.nixcord.config.enabledThemes = [ "matugenix.css" ];
      })
    ]
  );
}
