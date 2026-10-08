#!/usr/bin/env bash
# nano-config installer (Linux only)
set -euo pipefail

REPO="UfoFread699/nano-config"
BRANCH="main"
RAW_BASE="https://raw.githubusercontent.com/${REPO}/${BRANCH}"

# --- Linux only check ---
if [ "$(uname -s)" != "Linux" ]; then
  echo "Error: this config is Linux only." >&2
  exit 1
fi

# --- Requirements check ---
for cmd in nano curl; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: required command '$cmd' not found. Please install it first." >&2
    exit 1
  fi
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

# --- Backup existing config ---
if [ -f "$HOME/.nanorc" ]; then
  cp "$HOME/.nanorc" "$HOME/.nanorc.backup-${TIMESTAMP}"
  echo "Backed up ~/.nanorc to ~/.nanorc.backup-${TIMESTAMP}"
fi
if [ -d "$HOME/.nano" ]; then
  cp -r "$HOME/.nano" "$HOME/.nano.backup-${TIMESTAMP}"
  echo "Backed up ~/.nano to ~/.nano.backup-${TIMESTAMP}"
fi

mkdir -p "$HOME/.nano"

# --- Install from local checkout if available, otherwise download ---
if [ -f "${SCRIPT_DIR}/nanorc" ] && [ -d "${SCRIPT_DIR}/nano" ]; then
  echo "Installing from local files..."
  cp "${SCRIPT_DIR}/nanorc" "$HOME/.nanorc"
  cp "${SCRIPT_DIR}"/nano/*.nanorc "$HOME/.nano/"
else
  echo "Downloading nano-config v1.0.0 from GitHub..."
  TMP_DIR="$(mktemp -d)"
  trap 'rm -rf "$TMP_DIR"' EXIT
  curl -fsSL "${RAW_BASE}/nanorc" -o "$HOME/.nanorc"
  # Download syntax files via the file list to avoid hardcoding
  curl -fsSL "${RAW_BASE}/nano/filelist.txt" -o "${TMP_DIR}/filelist.txt"
  while IFS= read -r f; do
    [ -z "$f" ] && continue
    curl -fsSL "${RAW_BASE}/nano/${f}" -o "$HOME/.nano/${f}"
  done < "${TMP_DIR}/filelist.txt"
fi

echo "Done! Restart nano to apply the green minibar theme."
echo "Installed: ~/.nanorc + ~/.nano/*.nanorc"
