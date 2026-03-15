# igb_milan

`igb_milan` is a DKMS-style packaging project for the patched Intel `igb`
driver we used during Milan validation.

It is based on the stock Linux `igb` source, with the local changes that
proved useful in this lab:

- `disable_tx_latency_adjust`
- `disable_rx_latency_adjust`
- `disable_vlan_filter`

The project builds a separate module, `igb_milan.ko`, so it can coexist with
the stock `igb` source tree and be managed independently through DKMS.

## Licensing and Copyright

The `driver/` subtree was imported from the Linux kernel source package on this
host:

- `/usr/src/linux-source-6.12/drivers/net/ethernet/intel/igb`

Those imported files retain the upstream SPDX identifiers and copyright
notices from the kernel source.

The main notices currently present in this import are:

- most driver sources and headers:
  - `SPDX-License-Identifier: GPL-2.0`
  - `Copyright(c) 2007 - 2018 Intel Corporation.`
- `driver/Makefile`:
  - `SPDX-License-Identifier: GPL-2.0`
  - `Copyright(c) 1999 - 2018 Intel Corporation.`
- `driver/igb_ptp.c`:
  - `SPDX-License-Identifier: GPL-2.0+`
  - `Copyright (C) 2011 Richard Cochran <richardcochran@gmail.com>`

See [COPYRIGHT.md](COPYRIGHT.md) for the attribution summary added for this
repo.

## Layout

- `driver/`
  - patched `igb` driver source
- `dkms.conf`
  - DKMS package metadata
- `modprobe.d/igb_milan.conf.example`
  - example module preference/config file
- `scripts/install-dkms.sh`
  - copy to `/usr/src`, add/build/install with DKMS
- `scripts/uninstall-dkms.sh`
  - remove the DKMS package and optional modprobe config

## Requirements

- `dkms`
- matching kernel headers for the running kernel

For this host that is typically:

```bash
apt install dkms linux-headers-$(uname -r)
```

## Install

From the repo root:

```bash
cd /root/src/OpenAvnu/igb_milan
sudo ./scripts/install-dkms.sh
```

If you want the custom module to win on reboot, use the activation mode:

```bash
sudo ./scripts/install-dkms.sh --activate
sudo update-initramfs -u
```

That installs the example modprobe config and blacklists the stock `igb`
module so `igb_milan` can bind automatically on reboot.

Then reboot, or manually switch drivers.

## Verify

```bash
modinfo igb_milan
ethtool -i enp2s0
```

If the custom module is active, `ethtool -i` should report `driver: igb_milan`.

## Remove

```bash
cd /root/src/OpenAvnu/igb_milan
sudo ./scripts/uninstall-dkms.sh
```
