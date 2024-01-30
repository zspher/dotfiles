# Misc

miscellaneous scripts, configs, dotfiles and desktop tweaks (_now with nix_)

## Important commands

- view nixos system history

```sh
nix profile history --profile /nix/var/nix/profiles/system
```

- delete nixos generations

```sh
sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
```

```sh
sudo nix store gc --debug
```
