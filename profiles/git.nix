self: {...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      core.pager = "less -+X";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      rerere.enabled = true;
      push.default = "upstream";
    };
  };
}
