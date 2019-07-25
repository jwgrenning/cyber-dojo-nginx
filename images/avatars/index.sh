#!/bin/sh
set -e

# Thinking about renaming all avatar jpg files to be
# index based. Eg alligator.jpg --> 0.jpg
# The idea is that this decoupling will make it easier
# to replace the images to switch to a new set of avatars.
# If you do this, the Avatar.names (in web/app/models)
# will still hold the animal names though...

AVATAR_NAMES=(
  alligator
  antelope
  bat
  bear
  bee
  beetle
  buffalo
  butterfly
  cheetah
  crab
  deer
  dolphin
  eagle
  elephant
  flamingo
  fox
  frog
  gopher
  gorilla
  heron
  hippo
  hummingbird
  hyena
  jellyfish
  kangaroo
  kingfisher
  koala
  leopard
  lion
  lizard
  lobster
  moose
  mouse
  ostrich
  owl
  panda
  parrot
  peacock
  penguin
  porcupine
  puffin
  rabbit
  raccoon
  ray
  rhino
  salmon
  seal
  shark
  skunk
  snake
  spider
  squid
  squirrel
  starfish
  swan
  tiger
  toucan
  tuna
  turtle
  vulture
  walrus
  whale
  wolf
  zebra
)

index=0
for AVATAR_NAME in "${AVATAR_NAMES[@]}"; do
  echo "cp ${AVATAR_NAME}.jpg ${index}.jpg"
  index=$((index+1))
done
