#!/bin/bash
# treehouses image burner
# Author: An Pham
# Date: Sat Mar 14 11:12:19 EDT 2020

root_check () {
    if [ "$(id -u)" != "0" ]; then
          echo "This script must be run as root or with sudo" 1>&2
          exit 1
    fi
}

image_checker () {
  if [ ! "${1#*.}" == ".img.gz" ]; then
    echo "Error: can't find the image or the image type is invalid"
    exit 1 
  fi
}

erase_sd () {
  echo "WARNING: Starting to flash the $1 device"
  dd if=/dev/zero of="$1" status=progress bs=1M  ; ec="$?"
  [ "$ec" = 0 ] && echo "Success: Disk has been clean" || echo "Error: Disk failed to clean"
}

burn_sd () {
  # burn_sd <sD-name> <image-name>
  echo "Image path: $(readlink -f $2)"
  echo "Disk name: $1"
  echo "Flash the $1 now"

  gunzip -c "$2" | sudo dd of="$1" status=progress ; ec="$?"
  [ "$ec" = 0 ] && echo "Flashing completed!" || exit 1
}

download_and_burn_image () {
  root_check
  # download_and_burn_image '/dev/sdc' '124'
  echo "Downloading from http://dev.ole.org/treehouse-$2.img.gz"
  echo "Image name: treehouses-$2"
  echo "Disk name: $1"
  echo "Flashing the $1 now ... "

  curl "http://dev.ole.org/treehouse-$2.img.gz" | gunzip -c | sudo dd of="$1" status=progress ; ec="$?"
  [ "$ec" = 0 ] && echo "Done Flashing new image" || echo "Flashing failed" 

  umount "$2" ; ec="$?" ; sync 
  [ "$ec" = 0 ] && echo "Successfully umounted" || echo "Error: fail to unmount the device"
}

save_image () {
  # save_image <image_name> <block_device>
  local image_name="$1" 
  local block_device="$2"

  dd if="$block_device" of="$image_name" | gzip -c > "$image_name.img.gz" ; ec="$?"
  [ "$ec" = 0 ]  && echo "Sucess: image is backed up" || echo "Error: fail to back up the image"
}

images_management () {
  echo "Usuage: $(basename $0) [-l|--list] [-c|--clean <device_name>] [-b|--burn <device_name> <image_name>] "
  echo ''
  echo 'Where:'
  echo '  -h,--help    show the help page'
  echo '  -l,--list    show current saved images'
  echo '  -c,--clean   clean the disk drive' 
  echo "  -b,--burn    burn an image"
  echo "Example: "
  echo "  $(basename $0) -b /dev/sda treehouses.gz"
  echo ''
  echo ""
}

