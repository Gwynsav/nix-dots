{ colors }:

with colors; "
  .theme-dark {
    /* Foreground colors */
    --text-link                   : ${cya};
    --text-link-low-saturation    : ${cya_d};
    --text-positive               : ${grn};
    --text-warning                : ${ylw};
    --text-danger                 : ${red};
    --text-normal                 : ${nfg};
    --text-muted                  : ${dfg};
    --text-brand                  : ${wht};

    /* Background colors */
    --background-tertiary         : ${dbg};
    --background-secondary        : ${nbg};
    --background-secondary-alt    : ${nbg};
    --background-primary          : ${lbg};
    --channeltextarea-background  : ${nbg};
    --background-accent           : ${lbg};
    --background-modifier-hover   : ${gry};
    --background-modifier-active  : ${blk};
    --background-modifier-selected: ${blk};
    --deprecated-card-bg          : ${nbg};
    --background-floating         : ${blk};
    --scrollbar-auto-thumb        : ${blk};
    --scrollbar-auto-track        : ${lbg};
    --scrollbar-thin-thumb        : ${blk};
    --spotify-color               : ${grn_d};
    --elevation-low               : none;
    --deprecated-quickswitcher-input-background:${blk};
  }
"
