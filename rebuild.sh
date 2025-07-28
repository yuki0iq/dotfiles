#!/bin/sh
export NIX_PATH="nixpkgs=$(nix --extra-experimental-features nix-command eval --raw -f npins/default.nix nixpkgs):nixos-config=${PWD}/configuration.nix"
export http_proxy=socks://127.0.0.2:1080
export https_proxy=socks://127.0.0.2:1080
exec nixos-rebuild --sudo "$@"
