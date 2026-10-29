# Nixugen

**Declarative Nix configuration and template overlay for [Matugen](https://github.com/InioX/matugen)**

## Why?

Matugen's official module doesn't install `config.toml` into your home ([#60](https://github.com/InioX/matugen/issues/60)). Nixugen does, and its overlay provides pinned templates from matugen-themes, Dux Shell and Noctalia, so you don't need to keep copies in your dotfiles; the pins are updated automatically.

## Installation (via flakes)

```nix
# in flake.nix
{
  inputs.nixugen.url = "github:pyndys/nixugen";
}
```

## Overlay with templates

```nix
# NixOS or standalone Home Manager; adds pkgs.matugenTemplates
{ inputs, ... }:
{
  nixpkgs.overlays = [ inputs.nixugen.overlays.default ];
}
```

## Home Manager module

```nix
# in your home-manager configuration
{ inputs, ... }:
{
  imports = [ inputs.nixugen.homeModules.default ];
  programs.matugen = {
    enable = true;
  };
}
```

## [Hjem](https://github.com/feel-co/hjem) module

```nix
{ inputs, ... }:
{
  hjem = {
    extraModules = [ inputs.nixugen.hjemModules.default ];
    users.<user>.programs.matugen = {
      enable = true;
    };
  };
}
```

## Configuring

```nix
{ inputs, pkgs, ... }:
{
  programs.matugen = {
    enable = true;
    settings.templates = {
      example = {
        # source defaults to matugen-themes, variation to the source's default
        input_path = pkgs.matugenTemplates.<name>.<source>.<variation>;
        # or use a template from a path:
        # input_path = ./path/to/template.conf;
        output_path = "/path/to/generate/file.conf";
      };
    };
  };
}
```

## Applying the theme

To generate and apply the colors, you need to execute matugen. You can run it manually:

```shell
matugen image path/to/wallpaper.jpg
```

Note: If you are using a shell like Dux Shell, you don't need to run Matugen manually. Simply change your wallpaper (and enable "Run user templates" in its settings), and the theme will update automatically

## Similar projects

Nixugen doesn't compute colors in Nix: matugen runs at runtime, so changing the wallpaper never needs a rebuild. The projects below do the opposite and generate the palette at build time. That lets you use colors as Nix values and gives a reproducible theme, but every change means a rebuild. They solve a different problem, and since they also declare `programs.matugen`, they can't be imported together with Nixugen.

- [matugen-nix](https://github.com/MOIS3Y/matugen-nix): generates a palette from a wallpaper or seed color at evaluation time and exposes it as Nix attribute sets (Material You and Base16), for static theming of any option.
- [Matugen's official module](https://github.com/InioX/matugen): renders templates in the Nix store from a wallpaper or color set in your configuration and exposes the result as `theme.files` and `theme.colors`. It doesn't install `config.toml` or link the files.

## Credits

- [Matugen Themes](https://github.com/InioX/matugen-themes)
- [Dux Shell](https://github.com/duxlabs-dev/dux-shell)
- [Noctalia](https://github.com/noctalia-dev/noctalia)
- [Noctalia community templates](https://github.com/noctalia-dev/community-templates)
