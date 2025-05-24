#!/bin/sh
sudo env \
	NIX_PATH="nixpkgs=$(nix --extra-experimental-features nix-command eval --raw -f npins/default.nix nixpkgs):nixos-config=${PWD}/configuration.nix" \
	PROXY=socks://127.0.0.1:1080 \
	http_proxy=socks://127.0.0.1:1080 \
	https_proxy=socks://127.0.0.1:1080 \
	nixos-rebuild "$@"
