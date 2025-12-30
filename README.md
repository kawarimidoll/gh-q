# gh-q

[![LICENSE](https://img.shields.io/badge/license-MIT-brightgreen)](LICENSE)

A `gh` extension to clone GitHub repositories using `fzf` and `ghq`.

## Requirements

- [junegunn/fzf](https://github.com/junegunn/fzf)
- [x-motemen/ghq](https://github.com/x-motemen/ghq)

## Installation

```
gh extension install kawarimidoll/gh-q
```

### Upgrading

```
gh extension list
gh extension upgrade kawarimidoll/gh-q
```

## Usage

Fuzzy find your repo by `fzf` and clone it by `ghq`:

```
gh q
```

To clone other user's repo, pass username:

```
gh q kawarimidoll
```

## Installation with Nix / home-manager

Add the input to your `flake.nix`:

```nix
{
  inputs = {
    gh-q = {
      url = "github:kawarimidoll/gh-q";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```

Then add it to `programs.gh.extensions`:

```nix
{ inputs, pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = [
      inputs.gh-q.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
```

## Prior art

This extension is strongly inspired by [hashue/gh-fuzzyclone](https://github.com/hashue/gh-fuzzyclone).
