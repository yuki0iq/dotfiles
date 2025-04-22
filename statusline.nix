# vim:ts=2:sw=2:et:
{
  pkgs,
  lib,
  pins,
}: let
  fenix = pkgs.callPackage pins.fenix {};
in let
  toolchain = fenix.minimal.toolchain;
in
  (pkgs.makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  })
  .buildRustPackage (finalAttrs: {
    pname = "statusline";
    version = "0.21.0";

    src = pins.statusline;

    useFetchCargoVendor = true;
    cargoHash = "sha256-PFDrr4I5LWFybykbdTzNmDBqoA0+sKTlDBuoONjjceE=";

    # FIXME(25.05): edition 2024 is not supported yet
    auditable = false;

    meta = {
      description = "Fast and beautiful PS1 for bash";
      homepage = "https://codeberg.org/yuki0iq/statusline";
      license = lib.licenses.mit;
      maintainers = [];
    };
  })
