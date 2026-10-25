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
    dank16 = "${dux}/alacritty.toml";
    noctalia = "${noct}/alacritty/alacritty.toml";
  };
  foot = {
    matugen = "${mt}/foot-colors.ini";
    dank16 = "${dux}/foot.ini";
    noctalia = "${noct}/foot/foot";
  };
  ghostty = {
    matugen = "${mt}/ghostty";
    dank16 = "${dux}/ghostty.conf";
    noctalia = "${noct}/ghostty/ghostty";
  };
  kitty = {
    matugen = "${mt}/kitty-colors.conf";
    dank16 = "${dux}/kitty.conf";
    noctalia = "${noct}/kitty/kitty.conf";
  };
  btop = "${mt}/btop.theme";
  cava = "${mt}/cava-colors.ini";
  helix = {
    matugen = "${mt}/helix.toml";
    noctalia = "${noct}/helix/helix.toml";
  };
  fuzzel = "${mt}/fuzzel.ini";
  prismlauncher = "${mt}/prismlauncher.json";
  gtk = {
    gtk3 = "${noct}/gtk/gtk3.css";
    gtk4 = "${noct}/gtk/gtk4.css";
  };
  zen-browser = {
    userchrome = "${mt}/zen-userchrome.css";
    usercontent = "${mt}/zen-usercontent.css";
  };
  discord = {
    midnight = "${mt}/midnight-discord.css";
    system24 = "${mt}/system24.css";
    dms = "${dux}/vesktop.css";
    noctalia-midnight = "${nc}/discord/discord-midnight.css";
    noctalia-material = "${nc}/discord/discord-material.css";
    noctalia-system24 = "${nc}/discord/discord-system24.css";
  };
  steam = "${nc}/steam/steam.css";
}
