# SD Card Burner
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/) 
[![Documentation Status](https://readthedocs.org/projects/sd-burner/badge/?version=latest)](https://sd-burner.readthedocs.io/en/latest/?badge=latest)

## Introduction 
SD card image burning utility is written in bash to support QA operation of **treehouses** . Since the application is used by bash it only support Linux OS such as ubuntu, Debian, fedora. WARNING, be advised, DON'T flash the current running root partition to flash, you will loose your data. 

## Features
 - Burn and flash \*.img.gz image to a sd card or usb.
 - Download the latest **treehouses image** and burn it to a sd card.
 - Save current block device and compress to an image.
 - Send back-up images to sftp server. 

## Installations:
```
  git clone https://github.com/ole-vi/sd-burner sd-burner
  cd sd-burner
  chmod +x sd-burner
  sudo sd-burner -h 
```

## Usage
 - After downloading the source code. You can issue `./sd-burner -h` to check the help. 
 - Basic use-case
   1. `./sd-burner -c /dev/sdc ` will clean the block device `/dev/sdc/`.
   2. `./sd-burner -d /dev/sdc 124` will download the lastest image and burn it to /dev/sdc card.
   3. `./sd-burner --save <image_name> /dev/sdc` will save the image of current running block device.

## Inspiration:

 - This project is served as aspiration from @dogi via his image downloading scripts. 
 - We often find the need of burning new image for deployment during QA process. Although etcher seems to serve as main drive for burning new images, it's lack of image backing up features. 
