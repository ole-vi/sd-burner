#!/bin/env bats

@test "check_image" {
  source modules.sh 
  image_name='dummytest'
  block_device='/dev/sda'
  save_image "$image_name" "$block_device" ; $ec="$?"
  [ "$ec" -eq o ] 
}
 

