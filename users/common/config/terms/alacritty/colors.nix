{ colors }:

with colors; {
  primary = {
    background = "${nbg}";
    foreground = "${nfg}";
  };
  cursor  = {
    text       = "CellBackground";
    cursor     = "CellForeground";
  };
  normal  = {
    black   = "${lbg}";
    red     = "${red_d}";
    green   = "${grn_d}";
    yellow  = "${ylw_d}";
    blue    = "${blu_d}";
    magenta = "${mag_d}";
    cyan    = "${cya_d}";
    white   = "${gry}";
  };
  bright  = {
    black   = "${blk}";
    red     = "${red}";
    green   = "${grn}";
    yellow  = "${ylw}";
    blue    = "${blu}";
    magenta = "${mag}";
    cyan    = "${cya}";
    white   = "${dfg}";
  };
}
