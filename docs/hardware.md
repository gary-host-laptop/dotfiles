# ｈａｒｄｗａｒｅ

## ｇｈｏｓｔ－ｄｅｓｋｔｏｐ

| component | model |
|-----------|-------|
| monitor | ViewSonic Omni VX2418C 24" FHD Curved |
| motherboard | MSI H110M PRO-VH PLUS |
| cpu | AMD Ryzen 5 5600G — 6c/12t @ 4.4GHz |
| ram | Corsair Vengeance LPX 8GB DDR4 3000MHz C16 |
| case | Sentey Slim SS1-2426 |
| gpu | AMD Radeon Vega (integrated) |

## ｓｔｏｒａｇｅ

| label | mount | use |
|-------|-------|-----|
| root | `/` | fedora install + btrfs root |
| home | `/home` | btrfs subvolume; strata and `31_text` live here |
| valus | `/mnt/valus` | audio, images, game library |
| phaedra | `/mnt/phaedra` | video, steam library — currently unavailable |

## ｐａｒｔｉｔｉｏｎｓ

- strata lives on the btrfs `/home` subvolume, not on a separate partition; it
  survives an OS reinstall only when `/home` is preserved
- `31_text` is now local on the SSD; the external HDDs hold the remaining media
- hdds mounted via fstab at `/mnt/valus` and `/mnt/phaedra`
- selinux: hdd paths use `security_opt: label:disable` in docker compose
