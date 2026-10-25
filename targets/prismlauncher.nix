{ config, lib, ... }:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.prismlauncher;
  template = cfg.internal.templates.prismlauncher;
in
{
  options.programs.matugen.targets.prismlauncher.enable = lib.mkOption {
    type = lib.types.bool;
    default = cfg.targets.autoEnable;
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.prismlauncher.enable) {
    programs.matugen.settings.templates.prismlauncher = {
      input_path = template;
      output_path = "${config.xdg.dataHome}/PrismLauncher/themes/matugenix/theme.json";
    };

    programs.prismlauncher.settings.ApplicationTheme = "matugenix";
  };
}
