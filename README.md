# NixOS and home-manager configuration

100% less flakes!


## Apply this configuration

```shell
nixos-rebuild switch --sudo -A nixosConfigurations.$HOSTNAME
```

or, with extra nom,

```shell
nixos-rebuild switch --sudo -A nixosConfigurations.$HOSTNAME --log-format internal-json --show-trace |& nom --json
```

Tip: you can add `http_proxy` and `https_proxy` environment variables to `nixos-rebuild`.

Tip: you can analyze closure size with `nix-tree` and diff closures with

```shell
nix --extra-experimental-features nix-command store diff-closures /run/current-system ./result
```


## Tell me your secrets

Secrets should be placed under `/etc/nixos/secrets` directory.

Currently they are only needed if `meow.proxies.enable` NixOS option is set to `true`.

The contents of these files? That's a secret.


## TODO

- figure out how to autoformat everything except for `npins/` files. or don't and format these anyways
- `/users/{username}` is not the best idea, probably `/users/{username}@{hostname}` is better, e.g. for standalone home-manager configurations or servers where graphical system is unneeded
- make home-manager optional by gating it behind enable-style option or removing it completely
- gnome keybindings should probably use attrset (binding -> options) instead of list (binding; ...options)
- package overrides should probably live under separate nix files under separate directory (prismlauncher -> fjordlauncher, sublime-text)
- decide if modules should be Merged or Autoimported and maybe expose them in top-level
- use symlinkJoin instead of whatever currently is for anthy to move from home-manager
- check if docker-compose still works correctly
- check if sysbox works with nftables enabled, and if it does, check same with firewalld
- replace systemd-boot with refind + secure boot
- maybe use `services.byedpi` for byedpi?
- migrate `/etc/nixos/secrets` somewhere under `/var` and/or use something smarter than just Not Disclosing and not having them backed up
- migrate system configuration from chosen-user-writable `/etc/nixos` to somewhere under their home as nothing probably depends on it being there
- consider using userborn and etc overlay
- minimize closure size
- (lix 2.95) use log-format option instead of shell aliases
- (rust 1.92+) update statusline to latest commit
