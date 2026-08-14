{
  config,
  lib,
  matugen-themes,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.helix;
in
{
  options.programs.matugen.targets.helix.enable = lib.mkOption {
    type = lib.types.bool;
    default = cfg.targets.autoEnable;
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.helix.enable) {
    programs.matugen.settings.templates.helix = {
      input_path = "${matugen-themes}/templates/helix.toml";
      output_path = "${config.xdg.configHome}/helix/themes/matugenix.toml";
    };

    programs.helix.settings.theme = "matugenix";
  };
}
