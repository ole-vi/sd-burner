#!/bin/env bats

@test "check_image" {
  skip
  source modules2.sh 
  image_name='dummytest'
  block_device='/dev/sda'

  image_save "$image_name" "$block_device" ; ec="$?"
  [ "$ec" -eq o ] 
}

@test "check for loop device"  {
  source modules2.sh
  create_loop_device ; ec="$?"
  [ "$ec" -eq 0 ]
}

@test "burn_image"  {
  skip
  burn_image 
} 

@test "save_image"  {
  skip
  source modules2.sh
  # image_save <image_name> <block_device>
  image_save dummy-test-125 /dev/loop0 ; ec="$?"
  [ "$ec" -eq 0 ] 
}
