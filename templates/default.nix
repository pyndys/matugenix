{ pkgs }:
let
  src = import ./sources.nix { inherit pkgs; };
  mt = "${src.matugen-themes}/templates";
  dux = "${src.dux}/quickshell/matugen/templates";
  noct = "${src.noctalia}/assets/templates";
  nc = "${src.noctalia-community}";
  withDefault = default: set: set // { outPath = toString set.${default}; };
  single = source: path: withDefault source { ${source} = path; };
in
{
  alacritty = withDefault "matugen" {
    matugen = "${mt}/alacritty.toml";
    dux = "${dux}/alacritty.toml";
    noctalia = "${noct}/alacritty/alacritty.toml";
  };
  foot = withDefault "matugen" {
    matugen = "${mt}/foot-colors.ini";
    dux = "${dux}/foot.ini";
    noctalia = "${noct}/foot/foot";
  };
  ghostty = withDefault "matugen" {
    matugen = "${mt}/ghostty";
    dux = "${dux}/ghostty.conf";
    noctalia = "${noct}/ghostty/ghostty";
  };
  kitty = withDefault "matugen" {
    matugen = "${mt}/kitty-colors.conf";
    dux = "${dux}/kitty.conf";
    noctalia = "${noct}/kitty/kitty.conf";
  };
  btop = withDefault "matugen" {
    matugen = "${mt}/btop.theme";
    noctalia = "${noct}/btop/btop.theme";
  };
  cava = withDefault "matugen" {
    matugen = "${mt}/cava-colors.ini";
    noctalia = "${noct}/cava/cava.ini";
  };
  helix = withDefault "matugen" {
    matugen = "${mt}/helix.toml";
    noctalia = "${noct}/helix/helix.toml";
  };
  fuzzel = withDefault "matugen" {
    matugen = "${mt}/fuzzel.ini";
    noctalia = "${nc}/fuzzel/fuzzel.conf";
  };
  prismlauncher = withDefault "matugen" {
    matugen = "${mt}/prismlauncher.json";
    noctalia = "${nc}/prismlauncher/prismlauncher.json";
  };
  gtk = withDefault "matugen" {
    matugen = "${mt}/gtk-colors.css";
    dux = {
      colors = "${dux}/gtk-colors.css";
      light-colors = "${dux}/gtk-light-colors.css";
    };
    noctalia = {
      gtk3 = "${noct}/gtk/gtk3.css";
      gtk4 = "${noct}/gtk/gtk4.css";
    };
  };
  zen-browser = withDefault "matugen" {
    matugen = {
      userChrome = "${mt}/zen-userchrome.css";
      userContent = "${mt}/zen-usercontent.css";
    };
    dux.userChrome = "${dux}/zen-userchrome.css";
    noctalia = {
      userChrome = "${nc}/zen-browser/zen-userChrome.css";
      userContent = "${nc}/zen-browser/zen-userContent";
    };
  };
  discord = withDefault "matugen" {
    matugen = withDefault "midnight" {
      midnight = "${mt}/midnight-discord.css";
      system24 = "${mt}/system24.css";
    };
    dux = "${dux}/vesktop.css";
    noctalia = withDefault "midnight" {
      midnight = "${nc}/discord/discord-midnight.css";
      material = "${nc}/discord/discord-material.css";
      system24 = "${nc}/discord/discord-system24.css";
    };
  };
  steam = single "noctalia" "${nc}/steam/steam.css";
  telegram = withDefault "matugen" {
    matugen = "${mt}/telegram.tdesktop-theme";
    noctalia = "${nc}/telegram/telegram.tdesktop-theme";
  };
  niri = withDefault "matugen" {
    matugen = "${mt}/niri-colors.kdl";
    dux = "${dux}/niri-colors.kdl";
    noctalia = "${noct}/niri/niri.kdl";
  };
  hyprland = withDefault "matugen" {
    matugen = withDefault "lua" {
      lua = "${mt}/hyprland-colors.lua";
      conf = "${mt}/hyprland-colors.conf";
    };
    dux = "${dux}/hypr-colors.lua";
    noctalia = withDefault "lua" {
      lua = "${noct}/hyprland/hyprland.lua";
      conf = "${noct}/hyprland/hyprland.conf";
    };
  };
  mango = withDefault "matugen" {
    matugen = "${mt}/mango.conf";
    dux = "${dux}/mango-colors.conf";
    noctalia = "${noct}/mango/mango.conf";
  };
  labwc = withDefault "matugen" {
    matugen = "${mt}/labwc";
    noctalia = "${noct}/labwc/labwc.conf";
  };
  sway = withDefault "matugen" {
    matugen = "${mt}/sway-colors.conf";
    noctalia = "${noct}/sway/sway";
  };
  scroll = single "noctalia" "${noct}/scroll/scroll";
  umbriel = single "noctalia" "${noct}/umbriel/umbriel.toml";
  driftwm = single "noctalia" "${nc}/driftwm/driftwm-colors";
}
