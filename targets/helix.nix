{
  config,
  lib,
  matugen-themes,
  noctalia,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.helix;
in
{
  options.programs.matugen.targets.helix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };
    themeVariant = lib.mkOption {
      type = lib.types.enum [
        "matugenThemes"
        "noctalia"
      ];
      default = "matugenThemes";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.helix.enable) {
    programs.matugen.settings.templates.helix = {
      input_path =
        {
          matugenThemes = "${matugen-themes}/helix.toml";
          noctalia = "${noctalia}/helix/helix.toml";
        }
        .${targetCfg.themeVariant};
      output_path = "${config.xdg.configHome}/helix/themes/matugenix.toml";
    };

    programs.helix.settings.theme = "matugenix";
  };
}
