{ colors }:

with colors; {
  xresources = {
    extraConfig = ''
      !!! Monochrome
      *background : ${nbg}
      *color0     : ${lbg}
      *color8     : ${blk}
      *color7     : ${gry}
      *color15    : ${dfg}
      *foreground : ${nfg}

      !!! Colors
      *color1     : ${red_d}
      *color9     : ${red}
      *color2     : ${grn_d}
      *color10    : ${grn}
      *color3     : ${ylw_d}
      *color11    : ${ylw}
      *color4     : ${blu_d}
      *color12    : ${blu}
      *color5     : ${mag_d}
      *color13    : ${mag}
      *color6     : ${cya_d}
      *color14    : ${cya}

      !!! Font
      *faceName   : IBM Plex Mono:antialias=true
      *faceSize   : 11

      !!! Xterm is the fallback terminal
      !! Fixes      
      XTerm.*.bellIsUrgent    : true
      XTerm.*.metaSendsEscape : true
      XTerm.*.backarrowKey    : false
      XTerm.ttyModes          : erase ^?
      !! Bling
      XTerm.*.internalBorder  : 40
      XTerm.*.wideFont        : true
    '';
  };
}
