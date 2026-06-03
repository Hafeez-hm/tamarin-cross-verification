## Setup

This document captures the steps to install Homebrew and Tamarin on Linux or macOS.

### 1) Install Homebrew

Website: https://brew.sh/

Run the installer:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Linux details: https://docs.brew.sh/Homebrew-on-Linux

### 2) Add Homebrew to your shell

Run the following lines (per the Linux instructions) to ensure `brew` is on your PATH:

```bash
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
```

Verify Homebrew works by installing a test package:

```bash
brew install hello
```

### 3) Install Tamarin

Tamarin install docs: https://tamarin-prover.com/install.html

Install via Homebrew:

```bash
brew install tamarin-prover/tap/tamarin-prover
```

### 4) Tamarin Web GUI

The Tamarin web GUI runs on http://localhost:3001.
