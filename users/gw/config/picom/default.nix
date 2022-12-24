{ pkgs, colors, ... }:

{
  services.picom = {
    enable    = true;
    backend   = "glx";
    extraArgs = [ "--experimental-backends" ];

    shadow    = true;
    shadowExclude = [ "class_g *?= 'slop'" ];

    fade      = true;
    fadeDelta = 4;
    fadeSteps = [ 0.03 0.03 ];

    settings  = {
      # Optimization.
      glx-no-stencil       = true;
      glx-no-rebind-pixmap = true;
      xrender-sync-fence   = true;
      use-damage           = true;

      # Fancy shadows
      shadow-color         = "${nbg}";
    };

    wintypes  = {
      normal       = { full-shadow = true; };
      notification = { full-shadow = true; };
      tooltip      = { full-shadow = false; fade = false; focus = true; };
      dock         = { full-shadow = true; clip-shadow-above = true; };
      dnd          = { shadow = false; };
    };
  };
}
