{
  config,
  lib,
  noctalia-community,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.steam;
  theme = lib.attrByPath [ "programs" "steam" "theme" ] null config;
  themeEnabled = theme != null && (lib.getName theme) == "material-theme-steam";
in
{
  options.programs.matugen.targets.steam.enable = lib.mkOption {
    type = lib.types.bool;
    default = cfg.targets.autoEnable;
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && themeEnabled) {
    programs.matugen.settings.templates.steam = {
      input_path = "${noctalia-community}/steam/steam.css";
      output_path = "${config.xdg.dataHome}/Steam/steamui/skins/Material-Theme/css/main/colors/matugen.css";
    };

    programs.steam.millenniumConfig.themes.conditions."material-theme-steam"."Color" = "Matugen";
  };
}
