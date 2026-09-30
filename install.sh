#!/usr/bin/env bash
# SuTun Installer & Launcher Wrapper
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "${SCRIPT_DIR}/sutun.sh" ]]; then
    exec bash "${SCRIPT_DIR}/sutun.sh" "$@"
else
    exec bash <(curl -fsSL "https://raw.githubusercontent.com/mdjes/SuTun/main/sutun.sh") "$@"
fi
