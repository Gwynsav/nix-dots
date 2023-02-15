{ lib, stdenv, fetchzip, pkgs, ... }:

stdenv.mkDerivation rec {
  pname = "catppuccin-gtk";
  version = "0.4.0";

  src = fetchzip {
    url = "https://github.com/catppuccin/gtk/releases/download/v${version}/Catppuccin-Macchiato-Standard-Yellow-Dark.zip";
    sha256 = "sha256-6MFcPVaOKJQcj0i3xG8WuyKMWPOVWQ0GawJh43OYAWw=";
    stripRoot = false;
  };

  propagatedUserEnvPkgs = with pkgs; [
    gnome.gnome-themes-extra
    gtk-engine-murrine
  ];

  installPhase = ''
    mkdir -p $out/share/themes/
    cp -r Catppuccin-Macchiato-Standard-Yellow-Dark $out/share/themes
  '';

  meta = {
    description = "Soothing pastel theme for GTK3";
    homepage = "https://github.com/catppuccin/gtk";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
  };
}
