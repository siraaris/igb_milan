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

dkms remove -m "$package" -v "$version" --all || true

echo
echo "Removed ${package} ${version} from DKMS."
echo "If present, remove /etc/modprobe.d/igb_milan.conf and refresh initramfs manually."
