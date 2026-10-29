{
  description = "Declarative Nix configuration and template overlay for Matugen";
  outputs =
    { self, ... }:
    {
      homeModules.default = ./modules/hm.nix;
      hjemModules.default = ./modules/hjem.nix;
      lib.templates = pkgs: import ./templates { inherit pkgs; };
      overlays.default = final: _prev: {
        matugenTemplates = self.lib.templates final;
      };
    };
}
