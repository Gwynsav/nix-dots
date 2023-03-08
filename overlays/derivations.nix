final: prev: {
  aster          = prev.callPackage ../pkgs/aster.nix { };
  catppuccin-gtk = prev.callPackage ../pkgs/catppuccin-gtk.nix { };
}
