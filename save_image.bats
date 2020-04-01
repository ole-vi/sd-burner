#!/bin/env bats

@test "check_image" {
  source modules2.sh 
  image_name='dummytest'
  block_device='/dev/sda'

  image_save "$image_name" "$block_device" ; $ec="$?"
  [ "$ec" -eq o ] 
}

@test "check for loop device" () {
}

@test "burn_image" {
  burn_image 
} 

@test "save_image" {
  source modules2.sh
  # image_save <image_name> <block_device>
  image_save dummy-test-125 /dev/loop0 ; ec="$?"
  [ "$ec" = 0 ] 
}
