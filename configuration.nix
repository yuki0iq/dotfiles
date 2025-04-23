# vim:et:ts=2:sw=2
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{config, ...}: let
  pins = import ./npins;
  pkgs = import pins.nixpkgs {};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    (import "${pins.nixos-module}/module.nix" {lix = null;})
    (import "${pins.home-manager}/nixos")
  ];

  nix.settings.use-xdg-base-directories = true;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_14;
  boot.tmp.useTmpfs = true;
  security.allowSimultaneousMultithreading = false;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "yuuka";
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "en_DK.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ anthy table table-others ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };

  services.printing.enable = false;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  users.users.yuki = {
    isNormalUser = true;
    description = "yuki";
    extraGroups = ["networkmanager" "wheel"];
  };

  home-manager.users.yuki = import ./users/yuki;

  programs.firefox.enable = true;
  programs.firefox.package = pkgs.librewolf;

  programs.bash.completion.enable = true;
  programs.command-not-found.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
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
      core = {
        pager = "less -+X";
      };
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "Yuki Sireneva";
        email = "yuki.utk8g@gmail.com";
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
      gpg = {
        format = "ssh";
      };
      commit = {
        gpgsign = true;
      };
      tag = {
        gpgsign = true;
      };
      rerere = {
        enabled = true;
      };
      push = {
        default = "upstream";
      };
    };
  };

  programs.htop.enable = true;
  programs.tmux.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.obs-studio.enable = true;

  programs.ssh = {
    hostKeyAlgorithms = ["ssh-ed25519-cert-v01@openssh.com" "ssh-ed25519" "rsa-sha2-256" "rsa-sha2-512"];
    kexAlgorithms = ["sntrup761x25519-sha512" "sntrup761x25519-sha512@openssh.com" "mlkem768x25519-sha256"];
    ciphers = ["aes128-ctr" "aes128-gcm@openssh.com" "aes192-ctr" "aes256-ctr" "aes256-gcm@openssh.com"];
    macs = ["hmac-sha2-512-etm@openssh.com"];

    extraConfig = ''
      VisualHostKey yes
    '';
  };

  environment.systemPackages = with pkgs; [
    curl
    dua
    vulkan-tools
    wl-clipboard
    iperf3
    nmap
    socat
    lsof
    strace
    bat
    eza
    ripgrep
    refine
    file
    nix-output-monitor
    (pkgs.callPackage pins.npins {})
    mesa-demos
    alejandra
    ssh-audit
    prismlauncher
    (pkgs.callPackage pins.yukigram {})
    (pkgs.callPackage pins.fenix {}).complete.toolchain
    (pkgs.callPackage ./statusline.nix {pins = pins;})
    (nerdfonts.override {
      fonts = ["NerdFontsSymbolsOnly"];
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.openssh = {
    enable = true;

    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      UsePAM = true;

      KexAlgorithms = ["sntrup761x25519-sha512" "sntrup761x25519-sha512@openssh.com" "mlkem768x25519-sha256"];
      Ciphers = ["aes128-ctr" "aes128-gcm@openssh.com" "aes192-ctr" "aes256-ctr" "aes256-gcm@openssh.com"];
      Macs = ["hmac-sha2-512-etm@openssh.com"];
      HostKeyAlgorithms = "ssh-ed25519-cert-v01@openssh.com,ssh-ed25519,rsa-sha2-256,rsa-sha2-512";
      HostbasedAcceptedKeyTypes = "ssh-ed25519";
      PubkeyAcceptedKeyTypes = "sk-ssh-ed25519@openssh.com,ssh-ed25519";
      CASignatureAlgorithms = "ssh-ed25519";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
