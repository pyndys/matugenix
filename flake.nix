{
  description = "simple nix wrapper around matugen config";

  outputs =
    { self, ... }:
    {
      homeModules.default = import ./module.nix;
    };
}
