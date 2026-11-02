# ｈａｒｄｗａｒｅ

## ｇｈｏｓｔ－ｄｅｓｋｔｏｐ

| component | model |
|-----------|-------|
| monitor | ViewSonic Omni VX2418C 24" FHD Curved |
| motherboard | ASUSTeK COMPUTER INC. PRIME A320M-K |
| cpu | AMD Ryzen 5 5600G — 6c/12t @ 4.4GHz |
| ram | Corsair Vengeance LPX 8GB DDR4 3000MHz C16 |
| case | Sentey Slim SS1-2426 |
| gpu | AMD Radeon Vega (integrated) |

## ｓｔｏｒａｇｅ

| label | mount | use |
|-------|-------|-----|
| root | `/` | fedora install + btrfs root |
| home | `/home` | btrfs subvolume; strata, `31_text`, and `33_images` live here |
| valus | `/mnt/valus` | audio, game library |
| phaedra | `/mnt/phaedra` | video, steam library — currently unavailable |

## ｆｓｔａｂ

reference copy of `/etc/fstab` (non-secret; used only if the Plakar store is unavailable):

```fstab
#
# /etc/fstab
# Created by anaconda on Sun Nov 23 23:09:31 2025
#
# Accessible filesystems, by reference, are maintained under '/dev/disk/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info.
#
# After editing this file, run 'systemctl daemon-reload' to update systemd
# units generated from this file.
#
UUID=3c3cedf9-f218-47bb-b900-688ce08ce9d4 / btrfs subvol=root,compress=zstd:1,x-systemd.device-timeout=0 0 0
UUID=dd987884-cdf1-4f67-a7b7-8f956e964eab /boot ext4 defaults 1 2
UUID=3527-3964 /boot/efi vfat umask=0077,shortname=winnt 0 2
UUID=3c3cedf9-f218-47bb-b900-688ce08ce9d4 /home btrfs subvol=home,compress=zstd:1,x-systemd.device-timeout=0 0 0
UUID=a3e8f346-100a-49d1-8b7a-9bae9d3f411f /mnt/phaedra ext4 defaults,nosuid,nodev,nofail,auto,x-systemd.device-timeout=30,x-gvfs-show 0 2
UUID=1e69e263-232b-49b2-8138-6645fc104530 /mnt/valus ext4 defaults,nosuid,nodev,nofail,x-gvfs-show 0 2
```

## ｐａｒｔｉｔｉｏｎｓ

- strata lives on the btrfs `/home` subvolume, not on a separate partition; it
  survives an OS reinstall only when `/home` is preserved
- `31_text` and `33_images` are now local on the SSD; the external HDDs hold the
  remaining media
- hdds mounted via fstab at `/mnt/valus` and `/mnt/phaedra`
- selinux: hdd paths use `security_opt: label:disable` in docker compose
