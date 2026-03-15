#!/usr/bin/env bash
set -euo pipefail

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
	echo "Please run as root."
	exit 1
fi

if ! command -v dkms >/dev/null 2>&1; then
	echo "dkms is required but not installed."
	exit 1
fi

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version="$(<"$project_dir/VERSION")"
package="igb_milan"
dst="/usr/src/${package}-${version}"
activate=0

if [[ ${1:-} == "--activate" ]]; then
	activate=1
fi

echo "Installing ${package} ${version} into ${dst}"
rm -rf "$dst"
mkdir -p "$dst"
cp -a "$project_dir"/. "$dst"/

dkms remove -m "$package" -v "$version" --all >/dev/null 2>&1 || true
dkms add -m "$package" -v "$version"
dkms build -m "$package" -v "$version"
dkms install -m "$package" -v "$version"

if [[ $activate -eq 1 ]]; then
	cp "$project_dir/modprobe.d/igb_milan.conf.example" /etc/modprobe.d/igb_milan.conf
	echo "Installed /etc/modprobe.d/igb_milan.conf"
fi

echo
echo "Installed ${package} ${version} via DKMS."
if [[ $activate -eq 0 ]]; then
	echo "Optional next step:"
	echo "  $0 --activate"
fi
echo "If this host boots with stock igb from initramfs, refresh initramfs before reboot."
