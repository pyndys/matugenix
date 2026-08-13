{
  description = "simple nix wrapper around matugen config";

  outputs =
    { self, ... }:
    {
      homeManagerModules.default = import ./module.nix;
    };
}
