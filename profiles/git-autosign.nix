self: {...}: {
  programs.git.config = {
    gpg.format = "ssh";
    commit.gpgsign = true;
    tag.gpgsign = true;
  };
}
