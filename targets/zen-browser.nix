{
  config,
  lib,
  options,
  matugen-themes,
  ...
}:
let
  cfg = config.programs.matugen;
  targetCfg = cfg.targets.zen-browser;

  hasZen = options ? programs.zen-browser;
  zenEnabled = config.programs.zen-browser.enable or false;

  chromeOutput = "${config.xdg.configHome}/zen/matugenix/zen-userChrome.css";
  contentOutput = "${config.xdg.configHome}/zen/matugenix/zen-userContent.css";
in
{
  options.programs.matugen.targets.zen-browser = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.targets.autoEnable;
    };
    profile = lib.mkOption {
      type = lib.types.str;
      default = "default";
    };
  };

  config = lib.mkIf (cfg.enable && targetCfg.enable && zenEnabled) (
    lib.mkMerge [
      {
        programs.matugen.settings.templates = {
          zen-userchrome = {
            input_path = "${matugen-themes}/templates/zen-userchrome.css";
            output_path = chromeOutput;
          };
          zen-usercontent = {
            input_path = "${matugen-themes}/templates/zen-usercontent.css";
            output_path = contentOutput;
          };
        };
      }

      (lib.optionalAttrs hasZen {
        programs.zen-browser.profiles.${targetCfg.profile} = {
          userChrome = ''@import url("file://${chromeOutput}");'';
          userContent = ''@import url("file://${contentOutput}");'';
        };
      })
    ]
  );
}
