{
  config,
  lib,
  matugen-themes,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.fuzzel;
in
{
  options.programs.matugen.targets.fuzzel.enable = lib.mkOption {
    type = lib.types.bool;
    default = cfg.targets.autoEnable;
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.fuzzel.enable) {
    programs.matugen.settings.templates.fuzzel = {
      input_path = "${matugen-themes}/templates/fuzzel.ini";
      output_path = "${config.xdg.configHome}/fuzzel/matugenix.ini";
    };

    programs.fuzzel.settings.main.include = cfg.settings.templates.fuzzel.output_path;
  };
}
