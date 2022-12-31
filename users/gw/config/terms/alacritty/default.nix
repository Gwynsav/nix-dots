{ colors, ... }:

{
  programs.alacritty = {
    enable    = true;
    settings  = {
      window.padding = {
        x = 32;
        y = 32;
      };
      scrolling = {
        history    = 1024;
        multiplier = 3;
      };
      font = {
        normal = {
          family = "CaskaydiaCove Nerd Font";
          style  = "Regular";
        };
        bold = {
          family = "CaskaydiaCove Nerd Font";
          style  = "Bold";
        };
        italic = {
          family = "CaskaydiaCove Nerd Font";
          style  = "Italic";
        };
        bold_italic = {
          family = "CaskaydiaCove Nerd Font";
          style  = "Bold Italic";
        };
        size   = 11;
        box_drawing = true;
      };
      cursor = {
        style = {
          shape    = "Underline";
          blinking = "On";
        };
      };
      colors = import ./colors.nix { inherit colors; };
      live_config_reload = true;
    };
  };
}
