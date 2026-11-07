#!/bin/bash
# Kiln install: puts the Kiln menu-bar app in Applications and opens it.
#
#   curl -fsSL https://raw.githubusercontent.com/ffejeroni/kiln-releases/main/install.sh | bash
#
# Downloading with curl (not a browser) means macOS doesn't quarantine the app, so there's no
# "unidentified developer" block to click through. Safe to run again: it replaces Kiln.app with
# the newest build. Your plugins and settings are left alone.
set -euo pipefail

ZIP_URL="https://github.com/ffejeroni/kiln-releases/releases/download/latest/Kiln-Installer.zip"

say()  { printf '\033[1m%s\033[0m\n' "$*"; }
fail() { printf '\033[31m%s\033[0m\n' "$*" >&2; exit 1; }

[ "$(uname -s)" = "Darwin" ] || fail "Kiln is for macOS."
major=$(sw_vers -productVersion | cut -d. -f1)
[ "$major" -ge 13 ] || fail "The Kiln menu-bar app needs macOS 13 or later (this Mac has $(sw_vers -productVersion))."
[ "$(uname -m)" = "arm64" ] || say "Note: Kiln's plugins are built for Apple Silicon (M1 or later). This Mac is $(uname -m)."

# Applications if we can write there, otherwise your own Applications folder.
dest="/Applications"
if [ ! -w "$dest" ]; then dest="$HOME/Applications"; mkdir -p "$dest"; fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

say "Downloading Kiln..."
curl -fL --progress-bar "$ZIP_URL" -o "$tmp/Kiln-Installer.zip" || fail "Download failed. Check your connection and try again."
ditto -x -k "$tmp/Kiln-Installer.zip" "$tmp/unzipped"
[ -d "$tmp/unzipped/Kiln.app" ] || fail "The download didn't contain Kiln.app. Try again in a minute."

# Quit a running copy before replacing it.
osascript -e 'tell application "Kiln" to quit' >/dev/null 2>&1 || true
pkill -x Kiln >/dev/null 2>&1 || true
sleep 1

say "Installing to $dest..."
rm -rf "$dest/Kiln.app"
mv "$tmp/unzipped/Kiln.app" "$dest/Kiln.app"
xattr -dr com.apple.quarantine "$dest/Kiln.app" 2>/dev/null || true

open "$dest/Kiln.app"
say "Done. Kiln is in your menu bar (the flame, top right). Click it to install the plugins."
