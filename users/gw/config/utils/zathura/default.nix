# ----------------------------------- #
# -- Document Reader Configuration -- #
# ----------------------------------- #

{ colors, ... }:

{
  programs.zathura = {
    enable  = true;
    options = with colors; {
      default-bg                = "${nbg}";
      default-fg                = "${nfg}";

      statusbar-bg              = "${nbg}";
      statusbar-fg              = "${nfg}";

      inputbar-bg               = "${nbg}";
      inputbar-fg               = "${nfg}";

      notification-bg           = "${lbg}";
      notification-fg           = "${nfg}";

      notification-error-bg     = "${nbg}";
      notification-error-fg     = "${red}";

      notification-warning-bg   = "${lbg}";
      notification-warning-fg   = "${ylw}";

      highlight-color           = "${blk}";
      highlight-active-color    = "${blu}";

      completion-bg             = "${lbg}";
      completion-fg             = "${nfg}";

      completion-highlight-bg   = "${lbg}";
      completion-highlight-fg   = "${nfg}";

      recolor-lightcolor        = "${nbg}";
      recolor-darkcolor         = "${nfg}";

      recolor                   = true;
      recolor-keephue           = false;
    };
  };
}
