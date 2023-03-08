{ colors }:

{
  programs.discocss = {
    enable       = true;
    css          = import ./customCss.nix { inherit colors; };
    discordAlias = true;
  };
}
