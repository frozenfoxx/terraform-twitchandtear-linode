#!/usr/bin/env bash

# Variables
DATA_DIR=${DATA_DIR:-'/data'}
IMAGE=${IMAGE:-'frozenfoxx/twitchandtear:latest'}
RESTART=${RESTART:-'always'}
STREAM_KEY=${STREAM_KEY:-''}
TARGET_HOST=${TARGET_HOST:-''}

# Functions

## Install the container
install_container()
{
  echo "Setting up container..."
  docker pull ${IMAGE}
}

## Run the container
run_container()
{
  echo "Running the container..."
  docker run -it \
    -d \
    --restart=${RESTART} \
    -v ${DATA_DIR}/wads:/wads:ro \
    -e STREAM_KEY=${STREAM_KEY} \
    -e TARGET_HOST=${TARGET_HOST} \
    --name='twitchandtear' \
    ${IMAGE}
}

## Stop the container
stop_container()
{
  echo "Stopping the container..."
  docker kill twitchandtear
  echo y | docker container prune
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] twitchandtear_server.sh [arguments] [command]"
  echo "  Arguments:"
  echo "    -h                     display usage information"
  echo "  Commands:"
  echo "    install                set up and install the server"
  echo "    restart                restart the server"
  echo "    start                  start the server"
  echo "    stop                   stop the server"
  echo "  Environment Variables:"
  echo "    IMAGE                  the image to pull (default: 'frozenfoxx/twitchandtear:latest')"
  echo "    RESTART                the restart policy for the container (default: 'always')"
  echo "    STREAM_KEY             Twitch stream key (default: '')"
  echo "    TARGET_HOST            target Zandronum server (default: '')"
}

# Logic

## Argument parsing
while [[ "$1" != "" ]]; do
  case $1 in
    install )     install_container
                  run_container
                  ;;
    restart )     stop_container
	                install_container
                  run_container
                  ;;
    start )       install_container
                  run_container
                  ;;
    stop )        stop_container
                  ;;
    -h | --help ) usage
                  exit 0
                  ;;
    * )           usage
                  exit 1
  esac
  shift
done
