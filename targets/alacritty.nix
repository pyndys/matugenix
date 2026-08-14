{
  config,
  lib,
  matugen-themes,
  dms,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.alacritty;
in
{

  options.programs.matugen.targets.alacritty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };
    dank16 = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoDank16;
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && config.programs.alacritty.enable) {
    programs.matugen.settings.templates.alacritty = {
      input_path =
        if targetCfg.dank16 then
          "${dms}/quickshell/matugen/templates/alacritty.toml"
        else
          "${matugen-themes}/templates/alacritty.toml";
      output_path = "${config.xdg.configHome}/alacritty/matugenix.toml";
    };

    programs.alacritty.settings.general.import = [ "matugenix.toml" ];
  };
}
