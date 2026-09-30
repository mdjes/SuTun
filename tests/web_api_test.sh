#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../sutun.sh
source "${ROOT_DIR}/sutun.sh"

[[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.]+)?$ ]]
[[ "$DEFAULT_WEB_PORT" == "11080" ]]
[[ "$(get_web_port)" == "11080" ]]

# Test function declarations
declare -F update_web_assets >/dev/null
declare -F install_web_runtime >/dev/null
declare -F write_web_services >/dev/null
declare -F get_web_port >/dev/null
declare -F get_server_ip >/dev/null
declare -F generate_web_token >/dev/null
declare -F set_web_password >/dev/null
declare -F configure_web_port >/dev/null
declare -F create_haproxy_tunnel_noninteractive >/dev/null
declare -F edit_haproxy_tunnel_noninteractive >/dev/null
declare -F delete_haproxy_tunnel_noninteractive >/dev/null
declare -F create_iptables_tunnel_noninteractive >/dev/null
declare -F edit_iptables_tunnel_noninteractive >/dev/null
declare -F delete_iptables_tunnel_noninteractive >/dev/null
declare -F create_gost_tunnel_noninteractive >/dev/null
declare -F edit_gost_tunnel_noninteractive >/dev/null
declare -F delete_gost_tunnel_noninteractive >/dev/null
declare -F ensure_sutun_cli >/dev/null

# Test static assets exist
test -f "${ROOT_DIR}/web/server.py"
test -f "${ROOT_DIR}/web/static/index.html"
test -f "${ROOT_DIR}/systemd/sutun-web.service"
test -f "${ROOT_DIR}/systemd/sutun-iperf.service"

grep -Fq 'sutun-web.service' "${ROOT_DIR}/sutun.sh"
grep -Fq 'sutun-iperf.service' "${ROOT_DIR}/sutun.sh"
grep -Fq 'web|link|token|login-link) require_root; require_linux; generate_web_token' "${ROOT_DIR}/sutun.sh"
grep -Fq 'TimeoutStopSec=5' "${ROOT_DIR}/systemd/sutun-web.service"
grep -Fq 'TimeoutStopSec=5' "${ROOT_DIR}/systemd/sutun-iperf.service"
grep -Fq 'TimeoutStopSec=5' "${ROOT_DIR}/sutun.sh"
grep -Fq 'KillMode=mixed' "${ROOT_DIR}/systemd/sutun-web.service"
grep -Fq 'KillMode=mixed' "${ROOT_DIR}/sutun.sh"
grep -Fq 'threading.Thread(target=server.shutdown' "${ROOT_DIR}/web/server.py"
grep -Fq 'ensure_sutun_script' "${ROOT_DIR}/web/server.py"
grep -Fq '^/api/tunnels/(haproxy|iptables|gost|realm)/(create|edit|delete)$' "${ROOT_DIR}/web/server.py"

printf 'Web UI & speedtest helper tests passed.\n'
