{ pkgs }:
let
  src = import ./sources.nix { inherit pkgs; };
  mt = "${src.matugen-themes}/templates";
  dux = "${src.dux}/quickshell/matugen/templates";
  noct = "${src.noctalia}/assets/templates";
  nc = "${src.noctalia-community}";
in
{
  alacritty = {
    matugen = "${mt}/alacritty.toml";
    dux = "${dux}/alacritty.toml";
    noctalia = "${noct}/alacritty/alacritty.toml";
  };
  foot = {
    matugen = "${mt}/foot-colors.ini";
    dux = "${dux}/foot.ini";
    noctalia = "${noct}/foot/foot";
  };
  ghostty = {
    matugen = "${mt}/ghostty";
    dux = "${dux}/ghostty.conf";
    noctalia = "${noct}/ghostty/ghostty";
  };
  kitty = {
    matugen = "${mt}/kitty-colors.conf";
    dux = "${dux}/kitty.conf";
    noctalia = "${noct}/kitty/kitty.conf";
  };
  btop = {
    matugen = "${mt}/btop.theme";
    noctalia = "${noct}/btop/btop.theme";
  };
  cava = {
    matugen = "${mt}/cava-colors.ini";
    noctalia = "${noct}/cava/cava.ini";
  };
  helix = {
    matugen = "${mt}/helix.toml";
    noctalia = "${noct}/helix/helix.toml";
  };
  fuzzel = {
    matugen = "${mt}/fuzzel.ini";
    noctalia = "${nc}/fuzzel/fuzzel.conf";
  };
  prismlauncher = {
    matugen = "${mt}/prismlauncher.json";
    noctalia = "${nc}/prismlauncher/prismlauncher.json";
  };
  gtk = {
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
  zen-browser = {
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
  discord = {
    matugen = {
      midnight = "${mt}/midnight-discord.css";
      system24 = "${mt}/system24.css";
    };
    dms = "${dux}/vesktop.css";
    noctalia = {
      midnight = "${nc}/discord/discord-midnight.css";
      material = "${nc}/discord/discord-material.css";
      system24 = "${nc}/discord/discord-system24.css";
    };
  };
  steam = "${nc}/steam/steam.css";
}
