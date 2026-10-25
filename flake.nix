{
  description = "Declarative Nix configuration for Matugen";
  outputs =
    { self, ... }:
    {
      homeModules.default = ./module.nix;
      lib.templates = pkgs: import ./templates { inherit pkgs; };
      overlays.default = final: _prev: {
        matugenix.templates = self.lib.templates final;
      };
    };
}
