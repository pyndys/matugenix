{
  description = "Declarative Nix configuration for Matugen";
  inputs = {
    matugen-themes = {
      url = "github:InioX/matugen-themes?dir=templates";
      flake = false;
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell?dir=quickshell/matugen/templates";
      flake = false;
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia?dir=assets/templates";
      flake = false;
    };
    noctalia-community = {
      url = "github:noctalia-dev/community-templates";
      flake = false;
    };
  };

  outputs =
    {
      self,
      matugen-themes,
      dms,
      noctalia,
      noctalia-community,
      ...
    }:
    {
      homeModules.default = {
        imports = [ ./module.nix ];
        _module.args = {
          matugen-themes = matugen-themes;
          dms = dms;
          noctalia = noctalia;
          noctalia-community = noctalia-community;
        };
      };
    };
}
