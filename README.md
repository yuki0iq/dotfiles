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


## Tell me your secrets

Secrets should be placed under `/etc/nixos/secrets` directory.

Currently they are only needed if `meow.proxies.enable` NixOS option is set to `true`.

The contents of these files? That's a secret.


## TODO

- Figure out how to autoformat everything except for `npins/` files. Or don't and format these anyways.
- `/users/{username}` is not the best idea, probably `/users/{username}@{hostname}` is better, e.g. for standalone home-manager configurations or servers where graphical system is unneeded.
- Gate home-manager module behind "enable"-style option
- Make modules prettier
