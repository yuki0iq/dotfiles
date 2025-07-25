# vim:et:ts=2:sw=2
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{config, ...}: let
  pins = import ./npins;
  pkgs = import pins.nixpkgs {};
  fenixToolchain = (pkgs.callPackage pins.fenix {}).complete.toolchain;
  kernel = pkgs.linuxKernel.packageAliases.linux_latest;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./modules/git.nix
    ./modules/gnome.nix
    ./modules/ssh.nix

    (import "${pins.lix-nixos-module}/module.nix" {lix = null;})
    (import "${pins.home-manager}/nixos")
  ];

  nix.settings.use-xdg-base-directories = true;
  nix.nixPath = [
    "nixpkgs=${pins.nixpkgs}"
    "nixos-config=/etc/nixos/configuration.nix"
  ];

  boot.kernelPackages = kernel;
  boot.tmp.useTmpfs = true;
  zramSwap.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # FIXME(25.11): Enable by default
  system.rebuild.enableNg = true;

  networking.hostName = "yuuka";
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MEASUREMENT = "C.UTF-8";
    LC_PAPER = "C.UTF-8";
    LC_TIME = "en_DK.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      anthy
      # FIXME(25.05): https://nixpk.gs/pr-tracker.html?pr=420679
      # table
      # table-others
    ];
  };

  services.fwupd.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };

  services.printing.enable = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  xdg.terminal-exec.package = pkgs.xdg-terminal-exec-mkhl;

  virtualisation.docker.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  users.users.yuki = {
    isNormalUser = true;
    description = "yuki";
    extraGroups = ["networkmanager" "wheel" "docker"];
    openssh.authorizedKeys.keyFiles = [./users/yuki/authorized_keys];
  };

  home-manager.users.yuki = import ./users/yuki;

  programs.bash.completion.enable = true;
  programs.command-not-found = {
    enable = true;
    dbPath = "${pins.nixpkgs}/programs.sqlite";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    autosign = true;
    short-aliases = true;
    config = {
      user = {
        name = "Yuki Sireneva";
        email = "yuki.utk8g@gmail.com";
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

  programs.ssh.hardened = true;

  nixpkgs.overlays = [
    (self: super: {
      inherit fenixToolchain;
      statusline = super.callPackage "${pins.statusline}/statusline.nix" {};
      rycee = super.callPackage pins.rycee {};
    })
  ];

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix

    curl
    iperf3
    nmap
    socat
    ssh-audit

    bat
    bc
    dua
    eza
    libqalculate
    moreutils
    ripgrep

    kernel.cpupower
    kernel.perf
    lm_sensors
    pciutils
    usbutils

    file
    lsof
    mesa-demos
    strace
    vulkan-tools
    wl-clipboard

    alejandra
    nix-output-monitor
    npins

    fractal
    prismlauncher
    ((pkgs.callPackage pins.yukigram {}).overrideAttrs (self: super: {
      unwrapped = super.unwrapped.overrideAttrs {
        # FIXME(25.05 regression): Yukigram uses unreleased Telegram Desktop version and does not need
        # patches for Qt 6.9 support
        patches = [];
      };
    }))

    fenixToolchain
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = ["Noto Sans"];
        serif = ["Noto Serif"];
        monospace = ["Fantasque Sans Mono"];
      };
    };

    packages = with pkgs; [
      (fantasque-sans-mono.overrideAttrs (self: super: {
        installPhase =
          builtins.replaceStrings
          ["OTF" "otf" "opentype"]
          ["TTF" "ttf" "truetype"]
          super.installPhase;
      }))
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      texlivePackages.euler-math
    ];
  };

  services.openssh = {
    enable = true;
    hardened = true;
  };

  systemd.services = {
    shadowsocks-proxy = {
      enable = true;
      description = "shadowsocks client service";
      after = ["network.target"];
      wantedBy = ["default.target"];
      script = ''
        exec ${pkgs.shadowsocks-rust}/bin/sslocal -c /etc/nixos/secrets/shadowsocks.json
      '';
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "sublimetext4"
    ];
  # XXX: https://github.com/NixOS/nixpkgs/issues/239615
  # Blocked on upstream: https://github.com/sublimehq/sublime_text/issues/5984
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
