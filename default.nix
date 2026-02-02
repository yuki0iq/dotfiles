{
  system ? builtins.currentSystem,
  pins ? import ./npins,
  nixpkgs ? pins.nixpkgs,
  lib ? import "${nixpkgs}/lib",
  pkgs ? import nixpkgs {inherit system;},
  ...
}:
lib.fix (self: {
  inherit system nixpkgs;

  pins = (builtins.mapAttrs (name: pinned: pinned {inherit pkgs;}) pins) // {inherit nixpkgs;};

  lib = {
    readDir' = dir: let
      contents = builtins.readDir dir;
      isNixFile = name: kind: let
        masked = builtins.substring 0 1 name == "_";
        importable = kind == "directory" || kind == "regular" && lib.hasSuffix ".nix" name;
      in
        !masked && importable;
      filteredContents = lib.filterAttrs isNixFile contents;
      stripDotNix = s: builtins.replaceStrings [".nix##" "##"] ["" ""] (s + "##");
      transformPath = name: _: {
        name = stripDotNix name;
        value = lib.path.append dir name;
      };
    in
      lib.mapAttrs' transformPath filteredContents;

    nixosSystem = import "${self.pins.nixpkgs}/nixos";

    mkHost = name: path:
      self.lib.nixosSystem {
        specialArgs = {inherit self;};
        configuration.imports = (builtins.attrValues self.modules) ++ [path];
      };

    autoimport = dir: lib.mapAttrs (_: path: import path self) (self.lib.readDir' dir);
  };

  hosts = lib.mapAttrs self.lib.mkHost (self.lib.readDir' ./hosts);
  modules = self.lib.autoimport ./modules;
  profiles = self.lib.autoimport ./profiles;

  packages = {
    bg.yuuka = pkgs.fetchurl {
      urls = [
        "https://pixiv.net/img-original/img/2024/02/04/23/14/09/115770254_p0.jpg"
        "https://pixiv.ducks.party/img-original/img/2024/02/04/23/14/09/115770254_p0.jpg"
      ];
      hash = "sha256-jBVGOqZImknJ/gqSiplmCNII4skcvwxe8eE9mcxaVII=";
    };

    fantasque-sans-mono-ttf = pkgs.fantasque-sans-mono.overrideAttrs (final: prev: {
      installPhase = builtins.replaceStrings ["OTF" "otf" "opentype"] ["TTF" "ttf" "truetype"] prev.installPhase;
    });

    fjordlauncher-unwrapped = pkgs.prismlauncher-unwrapped.overrideAttrs (final: prev: {
      pname = "fjordlauncher-unwrapped";
      version = "10.0-unstable-2026-01-08";
      src = prev.src.override {
        owner = "unmojang";
        repo = "FjordLauncher";
        tag = null;
        rev = "31d3cc63669e60509c965cff5385ac2711691c4f";
        hash = "sha256-N6eGWxcNvKqUyFzHinOLV9NosH63eLMfCT8LAWHPTtI=";
      };
      patches = (prev.patches or []) ++ [./patches/fjordlauncher/0001-Make-FjordLauncher-DRM-free.patch];
      buildInputs = prev.buildInputs ++ [pkgs.kdePackages.qt5compat]; # XXX: This isn't mentioned anywhere, hacky
    });

    fjordlauncher = (pkgs.prismlauncher.override {prismlauncher-unwrapped = self.packages.fjordlauncher-unwrapped;}).overrideAttrs (final: prev: {
      pname = "fjordlauncher";
      name = "${final.pname}-${final.version}"; # XXX: otherwise the derivation is named prismlauncher-...
      qtWrapperArgs = map (builtins.replaceStrings ["PRISMLAUNCHER_JAVA_PATHS"] ["FJORDLAUNCHER_JAVA_PATHS"]) prev.qtWrapperArgs;
      meta = prev.meta // {mainProgram = "fjordlauncher";};
    });

    ibus-anthy = pkgs.ibus-engines.anthy.overrideAttrs (final: prev: {
      postInstall =
        (prev.postInstall or "")
        + ''
          substituteInPlace $out/share/ibus-anthy/engine/default.xml --replace-fail '<layout>jp</layout>' '<layout>default</layout>'
        '';
    });

    mpv-unwrapped = pkgs.mpv-unwrapped.overrideAttrs (final: prev: {
      # XXX: Remove when mpv from nixpkgs gains native support for /etc as system config dir
      mesonFlags = prev.mesonFlags ++ [(lib.mesonOption "sysconfdir" "/etc")];
    });

    rycee-nur = pkgs.callPackage self.pins.rycee {};

    statusline = pkgs.callPackage self.pins.statusline {};

    sublime4 = let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["sublimetext4"];
          # XXX: https://github.com/NixOS/nixpkgs/issues/239615
          # Blocked on upstream: https://github.com/sublimehq/sublime_text/issues/5984
          permittedInsecurePackages = ["openssl-1.1.1w"];
        };
      };
    in
      pkgs.sublime4.overrideAttrs (final: prev: {
        installPhase = builtins.replaceStrings ["${prev.passthru.unwrapped}"] ["${final.passthru.unwrapped}"] prev.installPhase;
        passthru.unwrapped = prev.passthru.unwrapped.overrideAttrs (final: prev: {
          # https://gist.github.com/JerryLokjianming/71dac05f27f8c96ad1c8941b88030451?permalink_comment_id=5590975
          postFixup =
            ''
              sed -i 's/\x0F\xB6\x51\x05\x83\xF2\x01/\xC6\x41\x05\x01\xB2\x00\x90/' "$out/sublime_text"
            ''
            + prev.postFixup;
        });
      });

    sysbox = pkgs.callPackage "${self.pins.abbradar-nixpkgs-ugractf}/pkgs/applications/virtualization/sysbox/default.nix" {};

    yukigram = pkgs.callPackage self.pins.yukigram {};
  };
})
