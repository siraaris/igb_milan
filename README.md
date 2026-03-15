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
