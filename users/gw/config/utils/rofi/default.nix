# ---------------------------------------- #
# -- Application Launcher Configuration -- #
# ---------------------------------------- #

{ config, colors, ... }:

{
  programs.rofi = {
    enable      = true;
    font        = "Noto Sans 10";
    extraConfig = {
      modi                = "drun";
      display-drun        = "";
      drun-display-format = "{name}";
      sidebar-mode        = false;
    };
    theme       = import ./theme.nix { inherit config colors; };
  };
}
