# NixOS and home-manager configuration

100% less flakes!


## Apply this configuration

```shell
nixos-rebuild switch --sudo -A hosts.$HOSTNAME
```

or, with extra nom,

```shell
nixos-rebuild switch --sudo -A hosts.$HOSTNAME --log-format internal-json --show-trace |& nom --json
```

Tip: you can add `http_proxy` and `https_proxy` environment variables to `nixos-rebuild`.

Tip: you can analyze closure size with `nix-tree` and diff closures with

```shell
nix --extra-experimental-features nix-command store diff-closures /run/current-system ./result
```


## Tell me your secrets

Secrets should be placed under `/var/secrets` directory. They are currently needed only if `profiles.proxies` is imported.

The contents of these files? That's a secret.


## TODO

- figure out how to autoformat everything except for `npins/` files. or don't and format these anyways
- `/users/{username}` is not the best idea, probably `/users/{username}@{hostname}` is better, e.g. for standalone home-manager configurations or servers where graphical system is unneeded
- make home-manager optional by gating it behind enable-style option or removing it completely (librewolf, sublime-text)
- overridden package autoupdate (fjordlauncher)
- replace systemd-boot with refind + secure boot
- consider using userborn and etc overlay
- minimize closure size
- (lix 2.95) use log-format option instead of shell aliases
- (rust 1.92+, on nixos-unstable now) update statusline to latest commit
