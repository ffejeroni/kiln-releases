#!/usr/bin/env bash
# Kiln for Linux: downloads the newest build and installs the plug-ins into your home folder.
# No root, no package manager: everything goes in ~/.vst3, ~/.lv2 and (if asked) ~/.clap.
#
#   curl -fsSL https://raw.githubusercontent.com/ffejeroni/kiln-releases/main/install-linux.sh | bash
#
# Options go after "bash -s --", for example:
#   curl -fsSL .../install-linux.sh | bash -s -- --all
#     (default)      VST3 and LV2
#     --clap         also the CLAP plug-ins, in ~/.clap
#     --standalone   also the standalone apps, in ~/.local/share/kiln/apps
#     --all          all of the above
#     --uninstall    remove every Kiln plug-in and app this script installed
# Safe to run again: it replaces the Kiln plug-ins with the newest build and leaves everything else alone.
set -euo pipefail

BASE="${KILN_BASE:-https://github.com/ffejeroni/kiln-releases/releases/download/latest}"
APPS="$HOME/.local/share/kiln/apps"

say()  { printf '\033[1m%s\033[0m\n' "$*"; }
fail() { printf '\033[31m%s\033[0m\n' "$*" >&2; exit 1; }

clap=0; standalone=0; uninstall=0
for a in "$@"; do
  case "$a" in
    --clap) clap=1 ;;
    --standalone) standalone=1 ;;
    --all) clap=1; standalone=1 ;;
    --uninstall) uninstall=1 ;;
    -h|--help) sed -n '2,14p' "$0" 2>/dev/null || true; exit 0 ;;
    *) fail "Unknown option: $a (try --clap, --standalone, --all or --uninstall)" ;;
  esac
done

[ "$(uname -s)" = "Linux" ] || fail "This installer is for Linux. On a Mac, use install.sh; on Windows, Kiln-Setup.exe."

if [ "$uninstall" = 1 ]; then
  say "Removing Kiln..."
  rm -rf "$HOME"/.vst3/Kiln\ *.vst3 "$HOME"/.lv2/Kiln\ *.lv2 "$HOME"/.clap/Kiln\ *.clap "$HOME/.local/share/kiln"
  say "Done. Your projects keep their settings if you install Kiln again."
  exit 0
fi

[ "$(uname -m)" = "x86_64" ] || fail "Kiln for Linux is built for 64-bit x86 (this computer is $(uname -m))."
command -v curl  >/dev/null || fail "Needs curl (for example: sudo apt install curl)."
command -v unzip >/dev/null || fail "Needs unzip (for example: sudo apt install unzip)."

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

get() {   # get NAME: download and unzip one release file into $tmp/NAME/
  say "Downloading $1..."
  curl -fL --progress-bar "$BASE/$1" -o "$tmp/$1" || fail "Download failed. Check your connection and try again."
  unzip -q "$tmp/$1" -d "$tmp/${1%.zip}"
}
put() {   # put SRC_DIR PATTERN DEST: replace each matching item in DEST with the new one
  mkdir -p "$3"
  local n=0
  for item in "$1"/$2; do
    [ -e "$item" ] || continue
    rm -rf "$3/$(basename "$item")"
    cp -R "$item" "$3/"
    n=$((n + 1))
  done
  echo "  $n into $3"
}

get Kiln-linux-x64.zip
put "$tmp/Kiln-linux-x64/VST3" "*.vst3" "$HOME/.vst3"
put "$tmp/Kiln-linux-x64/LV2" "*.lv2" "$HOME/.lv2"

if [ "$clap" = 1 ]; then
  get Kiln-linux-x64-CLAP.zip
  put "$tmp/Kiln-linux-x64-CLAP" "*.clap" "$HOME/.clap"
fi

if [ "$standalone" = 1 ]; then
  get Kiln-linux-x64-Standalone.zip
  put "$tmp/Kiln-linux-x64-Standalone" "Kiln*" "$APPS"
  chmod +x "$APPS"/Kiln\ * 2>/dev/null || true
fi

say "Kiln is installed."
echo "Rescan plug-ins in your DAW (Reaper, Bitwig, Ardour and others). They're under Kiln."
[ "$standalone" = 1 ] && echo "Standalone apps are in $APPS."
[ "$clap" = 0 ] && echo "Want CLAP too? Run this again with: | bash -s -- --clap"
echo "Help: kilnplugin.com (the Help button, bottom right)"
