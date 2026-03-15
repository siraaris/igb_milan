# Copyright and Attribution

`igb_milan` is based on the Linux kernel `igb` driver source imported from:

- `/usr/src/linux-source-6.12/drivers/net/ethernet/intel/igb`

into this repository's `driver/` directory.

## Upstream driver notices

The imported driver files retain their original SPDX and copyright notices.
The key notices present in this tree are:

- Most files under `driver/`:
  - `SPDX-License-Identifier: GPL-2.0`
  - `Copyright(c) 2007 - 2018 Intel Corporation.`
- `driver/Makefile`:
  - `SPDX-License-Identifier: GPL-2.0`
  - `Copyright(c) 1999 - 2018 Intel Corporation.`
- `driver/igb_ptp.c`:
  - `SPDX-License-Identifier: GPL-2.0+`
  - `Copyright (C) 2011 Richard Cochran <richardcochran@gmail.com>`

Representative files in this repository carrying those notices include:

- `driver/igb_main.c`
- `driver/igb.h`
- `driver/e1000_82575.c`
- `driver/e1000_i210.c`
- `driver/e1000_mac.c`
- `driver/e1000_nvm.c`
- `driver/e1000_phy.c`
- `driver/igb_ethtool.c`
- `driver/igb_hwmon.c`
- `driver/igb_ptp.c`

## Local project scope

This repository packages the patched driver as `igb_milan.ko` together with
DKMS metadata and helper scripts so it can be built and installed separately
from the stock `igb` module.

The local changes in this repository are intended to remain distributed under
the same GPL terms as the imported upstream driver sources.
