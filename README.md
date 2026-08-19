# Matugenix

### Declarative Nix configuration for [Matugen](https://github.com/InioX/matugen) with dynamic color generation

## Installation (via flakes)
```nix
# in flake.nix
inputs.matugenix.url = "github:pyndys/matugenix";
```

```nix
# in your home-manager configuration
{ inputs, ... }:
{
  imports = [
    inputs.matugenix.homeModules.default
  ];
  programs.matugen = {
    enable = true;
  };
}
```

## Features

### [Stylix](https://github.com/nix-community/stylix)-like targets system
You can easily manage which programs should be themed by Matugen
```nix
{
  programs.matugen = {
    targets = {
      # you can configure targets individually
      equibop = {
        enable = true;
        themeVariant = "system24";
    };
      # or enable all those that have home-manager modules enabled
      autoEnable = true;
    };
  };
}
```

### Support for dank16/noctalia terminal colors
```nix
{
  programs.matugen.targets = {
    # you can enable it for all supported targets
    autoTerminalColors = "dank16";
    # or customize colors separately for each target
    alacritty.terminalColors = "noctalia";
  };
}
```

## Applying the theme
To generate and apply the colors, you need to execute matugen. You can run it manually:
```shell
matugen image path/to/wallpaper.jpg
```
Note: If you are using a shell like Noctalia or DankMaterialShell, you don't need to run Matugen manually. Simply change your wallpaper, and the theme will update automatically

## Credits
- [Matugen Themes](https://github.com/InioX/matugen-themes)
- [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell)
- [Noctalia](https://github.com/noctalia-dev/noctalia)
- [Noctalia community templates](https://github.com/noctalia-dev/community-templates)
