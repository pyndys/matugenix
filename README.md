# Matugenix

### Declarative Nix configuration for [Matugen](https://github.com/InioX/matugen)

## Why?
Matugen's official module can't write its own config.toml declaratively (https://github.com/InioX/matugen/issues/60). It also doesn't automatically symlink files. Matugenix fixes both issues and adds targets like in Stylix to avoid having to write templates manually 

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

### Custom templates via `settings`
Targets cover common applications, but you're never blocked by what's (not yet) covered - `programs.matugen.settings` accepts raw matugen configuration, merged together with whatever your enabled targets already generate:
```nix
{ config, ... }:
{
  programs.matugen.settings.templates.my-app = {
    input_path = ./templates/app.conf;
    output_path = "${config.xdg.configHome}/app/colors.conf";
  };
}
```
Use targets where available, drop down to `settings` for everything else - both write into the same `templates.*` namespace, so they compose freely without conflicting

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
