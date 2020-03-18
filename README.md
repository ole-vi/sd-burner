# SD Card Burner
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/) 

## Introduction 
SD card image burning utility is written in bash to support QA operation of **treehouses** . Since the application is used by bash it only support Linux OS such as ubunt, debian, fedora. WARNING, be advised, DON'T flash the current running root partition to flash, you will loose your data. 

## Features
 - Burn and flash \*.img.gz image to and sd card or usb.
 - Download the latest **treehouses image** and burn it to an sd card.
 - Save current block device and compress to an image.
 - Send back up images to sftp server. 

## Installation:
```
  git clone https://github.com/ole-vi/sd-burner sd-burner
  cd sd-burner
  chmod +x sd-burner
  sudo sd-burner -h 
```

## Usage
 - After downloading the source code. You can issue `./sd-burner -h` to check the help. 
 - Basic use cases
   1. `./sd-burner -c /dev/sdc ` will clean the block device `/dev/sdc/`.
   2. `./sd-burner -d /dev/sdc 124` will download the lastest image and burn it to /dev/sdc card.

## Inspiration:
 - This project is served as aspiration from @dogi via his image downloading scripts. 
 - We often find the need of burning new image for deployment during QA process. Although etcher seems to serve as main drive for burning process, it is lack of backing up features. 
