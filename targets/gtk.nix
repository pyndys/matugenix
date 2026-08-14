{
  config,
  lib,
  matugen-themes,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.gtk;
  templatesCfg = cfg.settings.templates;
in
{
  options.programs.matugen.targets.gtk.enable = lib.mkOption {
    type = lib.types.bool;
    default = cfg.targets.autoEnable;
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable) {
    programs.matugen.settings.templates = {
      gtk4 = {
        input_path = "${matugen-themes}/templates/gtk-colors.css";
        output_path = "${config.xdg.configHome}/gtk-4.0/matugenix-colors.css";
      };
      gtk3 = {
        input_path = templatesCfg.gtk4.input_path;
        output_path = "${config.xdg.configHome}/gtk-4.0/matugenix-colors.css";
      };
    };

    gtk = {
      enable = true;
      gtk4.extraCss = "@import url(\"${templatesCfg.gtk4.output_path}\");";
      gtk3.extraCss = "@import url(\"${templatesCfg.gtk3.output_path}\");";
    };
  };
}
