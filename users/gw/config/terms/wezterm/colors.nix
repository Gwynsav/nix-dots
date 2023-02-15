{ colors, ... }:

with colors; {
  followSystem = {
    # basic colors
    background    = "${nbg}";
    cursor_bg     = "${dfg}";
    cursor_border = "${dfg}";
    cursor_fg     = "${nbg}";
    foreground    = "${nfg}";
    selection_bg  = "${wht}";
    selection_fg  = "${nbg}";
    split         = "${lbg}";

    # base16
    ansi    = [
      "${lbg}" "${red_d}" "${grn_d}" "${ylw_d}"
      "${blu_d}" "${mag_d}" "${cya_d}" "${gry}"
    ];
    brights = [
      "${blk}" "${red}" "${grn}" "${ylw}"
      "${blu}" "${mag}" "${cya}" "${wht}"
    ];

    # tabbar
    tab_bar = {
      background = "${lbg}";
      active_tab = { 
        bg_color = "${nbg}";
        fg_color = "${nfg}";
      };
      inactive_tab = {
        bg_color = "${lbg}";
        fg_color = "${dfg}";
      };
      inactive_tab_hover = {
        bg_color = "${blk}";
        fg_color = "${dfg}";
      };
      inactive_tab_edge = "${blk}";
      new_tab = {
        bg_color = "${lbg}";
        fg_color = "${dfg}";
      };
      new_tab_hover = {
        bg_color = "${blk}";
        fg_color = "${nfg}";
      };
    };
  };
}
