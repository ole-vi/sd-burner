#!/bin/bash
# Date: Sat Mar 14 11:12:19 EDT 2020
# Description: 
# Module List:
#  - Burn new image
#  - Provide Image backup 
#  - Erase the block device 

# the function comes with bats file for automate testing

## Global Variable Decalre ## 

## Function ## 
root_check () {
    if [ "$(id -u)" != "0" ]; then
        echo "This script must be run as root or with sudo" 1>&2
        exit 1
    fi
}



create_loop_device () {
  local file_size='16G'
  local file_name='./dummy.img'
  local next_loop_device="$(sudo losetup -f)"

  root_check
  fallocate -l "$file_size" "$file_name" && echo "Finished creating dummy file" 
  # check loop device here 
  losetup "$next_loop_device" "$file_name"  && echo 'Loop device successfully mounted' 
}

image_checker () {
    if [ ! "${1#*.}" == ".img.gz" ]; then
        echo "Error: can't find the image or the image type is invalid"
        exit 1 
    fi
}

image_save () {
  # image_save <image_name> <block_device>
  local image_name="$(date +%Y-%m-%d)_$1" 
  local block_device="$2"
  root_check
  if [ -n "$2" ];
  then
        dd if="$block_device" conv=sync | gzip -c > "$image_name.img.gz" ; ec="$?"
        [ "$ec" -eq 0 ]  && echo "Sucess: image is backed up" || echo "Error: fail to back up the image"  
    du -h "$image_name.img.gz"
  else
    echo "Error: fail to back up the image"
  fi
}

erase_sd(){
    echo "WARNING: Starting to format the $1 device"
    dd if=/dev/zero of="$1" status=progress ; ec="$?"
    [ "$ec" = 0 ] && echo "Success: Disk has been clean" || echo "Error: Disk failed to clean"
}

burn_sd () {
  # burn_sd <image_path> <disk_path>
    echo "Image path: $(readlink -f "$1")"
    echo "Disk name: $2"
  echo ""
    echo "Flashing  the $1 now ... "

    gunzip -c "$1" | sudo dd of="$2" status=progress ; ec="$?"
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

    umount "$1" ; ec="$?" ; sync 
    [ "$ec" = 0 ] && echo "Successfully umounted" || echo "Error: fail to unmount the device"
}

sdburner_help () {
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
}

## End of Function ## 
