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

## Prior art

This extension is strongly inspired by [hashue/gh-fuzzyclone](https://github.com/hashue/gh-fuzzyclone).
