#!/bin/sh
#Runs at startup, switches rootfs to the SSD on nvme0 (M.2 Key M slot)
NVME_DRIVE="/dev/nvme0n1p1"
CHROOT_PATH="/nvmeroot"

INITBIN=/lib/systemd/systemd
EXT4_OPT="-o defaults -o debug -o errors=continue -o discard"

echo "setssdroot: mount and switch rootfs to nvme0n1p1" | tee /dev/kmsg

modprobe ext4

mkdir -p ${CHROOT_PATH}
mount -t ext4 ${EXT4_OPT} ${NVME_DRIVE} ${CHROOT_PATH}

cd ${CHROOT_PATH}
/bin/systemctl --no-block switch-root ${CHROOT_PATH}

echo "setssdroot: exit mount and switch rootfs" | tee /dev/kmsg
