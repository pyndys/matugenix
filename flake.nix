{
  description = "simple nix wrapper around matugen config";
  inputs = {
    matugen-themes = {
      url = "github:InioX/matugen-themes";
      flake = false;
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      flake = false;
    };
  };

  outputs =
    {
      self,
      matugen-themes,
      dms,
      ...
    }:
    {
      homeModules.default = {
        imports = [ ./module.nix ];
        _module.args = {
          matugen-themes = matugen-themes;
          dms = dms;
        };
      };
    };
}
