{ colors, ... }:

{
  programs.kitty = {
    enable      = true;
    extraConfig = import ./colors.nix { inherit colors; };
    settings    = {
      window_padding_width    = 32;
      confirm_os_window_close = 0;
      cursor_shape            = "underline";
      disable_ligatures       = "always";
      scrollback_lines        = 512;
    };
    font = {
      size = 11;
      name = "CaskaydiaCove Nerd Font";
    };
  };
}
