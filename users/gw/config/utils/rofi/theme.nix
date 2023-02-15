{ config, colors, ... }:

let inherit (config.lib.formats.rasi) mkLiteral; in
with colors; {
  "*" = {
    bg                = mkLiteral "${nbg}";
    fg                = mkLiteral "${nfg}";
    button            = mkLiteral "${lbg}";
    background-color  = mkLiteral "@bg";
    text-color        = mkLiteral "@fg";

    img               = mkLiteral "url(\"/etc/nixos/users/gw/config/utils/rofi/img/${theme}.png\")";
  };

  "#window"   = {
    transparency      = "real";
    border-color      = mkLiteral "@button";
    border-radius     = mkLiteral "10px";
    border            = mkLiteral "2px";
    width             = mkLiteral "33%";
  };
  "#mainbox"  = {
    children          = map mkLiteral [ "inputbar" "listview" ];
  };

  "#inputbar" = {
    children          = map mkLiteral [ "prompt" "entry" ];
    background-image  = mkLiteral "@img";
    expand            = false;
    border-radius     = mkLiteral "0px 0px 8px 8px";
    padding           = mkLiteral "13% 1.5% 3% 18.25%";
  };
  "#prompt"   = {
    enabled           = false;
  };
  "#entry"    = {
    placeholder       = "Search";
    placeholder-color = mkLiteral "@fg";
    expand            = true;
    border-radius     = mkLiteral "8px";
    padding           = mkLiteral "1.5%";
  };

  "#listview" = {
    columns           = 2;
    lines             = 4;
    cycle             = true;
    dynamic           = true;
    layout            = mkLiteral "vertical";
    padding           = mkLiteral "3% 1.5% 3% 1.5%";
  };

  "#element"  = {
    orientation       = mkLiteral "vertical";
    border-radius     = mkLiteral "8px";
    padding           = mkLiteral "1.5% 0% 1.5% 0%";
  };
  "#element-text" = {
    expand            = true;
    vertical-align    = mkLiteral "0.5";
    margin            = mkLiteral "0.5% 3% 0% 3%";
    background-color  = mkLiteral "inherit";
    text-color        = mkLiteral "inherit";
  };
  "#element selected" = {
    background-color  = mkLiteral "@button";
    border-radius     = mkLiteral "8px";
  };
}
