<!-- markdownlint-disable MD013 -->

# Nix Setup

This guide provides instructions for setting up Nix, enabling experimental features, and installing Home Manager on both non-NixOS Linux and macOS systems. Nix is a powerful package manager for Linux and other Unix systems that makes package management reliable and reproducible. Home Manager is a tool that allows you to manage your user environment using the Nix package manager.

## Nix Installation

- For non-NixOS Linux system:

  ```sh
  sh <(curl -L https://nixos.org/nix/install) --daemon
  ```

- For macOS system:

  ```sh
  sh <(curl -L https://nixos.org/nix/install)
  ```

## Enable Flakes

Add following line to [`~/.config/nix/nix.conf`](../nix/nix.conf):

```conf
experimental-features = nix-command flakes
```

## Install Home Manager

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

### For Standalone

For standalone installation, e.g. on non-NixOS Linux system, run the following command to install Home Manager:

```sh
nix-shell '<home-manager>' -A install
```

## Switch Configuration

### For non-NixOS Linux System

```sh
home-manager switch --flake .
```

### For macOS System

The Home Manager configuration is managed by `darwin-rebuild`. To switch configuration, run the following command:

```sh
darwin-rebuild switch --flake .
```
