# vim:et:ts=2:sw=2
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.git;
in {
  options = {
    programs.git = {
      short-aliases = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable opinionated short aliases";
      };

      autosign = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable automatic ssh signature of commits and tags";
      };
    };
  };

  config = {
    programs.git.config = lib.mkMerge [
      {
        core.pager = "less -+X";
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
        rerere.enabled = true;
        push.default = "upstream";
      }
      (lib.mkIf cfg.autosign {
        gpg.format = "ssh";
        commit.gpgsign = true;
        tag.gpgsign = true;
      })
      (lib.mkIf cfg.short-aliases {
        alias = {
          git = "!git";
          l = "log --topo-order --graph --decorate --format=format:\"%C(bold blue)%h%C(reset) %C(dim italic cyan)%ah%C(reset) %C(dim white)%aN%C(reset) %C(green)(%ar)%C(reset)%C(yellow)%d%C(reset) %C(italic dim white)%GS%C(reset)%n %C(white)%s%C(reset)\"";
          ll = "!git l --all";
          ld = "!git ll --simplify-by-decoration";
          lr = "!git ll $(git rev-list -g --all)";
          lo = "!git l --oneline";
          llo = "!git ll --oneline";
          lro = "!git lr --oneline";
          ldo = "!git ld --oneline";
          p = "push";
          pp = "push --force-with-lease";
          ppp = "push --force";
          take = "pull --rebase";
          f = "fetch";
          fa = "fetch --all";
          b = "branch";
          bf = "branch -f";
          br = "branch -d";
          brr = "branch -D";
          bm = "branch -M";
          s = "status";
          a = "add -u";
          ai = "add -i";
          ap = "add -p";
          d = "diff";
          ds = "diff --staged";
          do = "diff --ours";
          dt = "diff --theirs";
          c = "commit";
          cc = "commit -m";
          ca = "commit --amend";
          cf = "commit --fixup";
          co = "checkout";
          cob = "checkout -b";
          cobb = "checkout -B";
          cpi = "cherry-pick";
          cpa = "cherry-pick --abort";
          cpc = "cherry-pick --continue";
          me = "merge --no-ff";
          mea = "merge --abort";
          mec = "merge --continue";
          meff = "merge --ff-only";
          su = "submodule";
          sud = "submodule deinit --force --all";
          sus = "submodule status --recursive";
          sui = "submodule init --recursive";
          suu = "submodule update --init --recursive";
          re = "rebase --rebase-merges";
          rei = "rebase --rebase-merges -i";
          reo = "rebase --rebase-merges --onto";
          reio = "rebase --rebase-merges -i --onto";
          rea = "rebase --abort";
          "rec" = "rebase --continue";
          reskip = "rebase --skip";
          retodo = "rebase --edit-todo";
          resoft = "reset --soft";
          rehard = "reset --hard";
        };
      })
    ];
  };
}
