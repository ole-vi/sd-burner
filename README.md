# SD Card Burner
 
## Introduction 
SD card image burning utility is written in bash to support QA operation of treehouses.

## Features
 - Burn and \*.img.gz image to and sd card or usb.
 - Download the latest **treehouses image** and burn it to an sd card.
 - Save current block device and compress to an image.
 - Send back up images to sftp server. 

## Installation:
```
  git clone https://github.com/ole-vi/sd-burner sd-burner
  chmod +x sd-burner
  sudo sd-buner -h 
```

## Inspiration:
 - This project is served as aspiration from @dogi via his image downloading scripts. 
 - We often find the need of burning new image for deployment during QA process. Although etcher seems to serve as main drive for burning process, it is lack of backing up features. 
