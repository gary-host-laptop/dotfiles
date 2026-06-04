#!/bin/bash
find ~/strata/10-19_system/16_inbox -maxdepth 1 -type f \
  \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
     -o -iname "*.webp" -o -iname "*.gif" \) \
  -exec mv -t ~/strata/30-39_media/33_images {} +
