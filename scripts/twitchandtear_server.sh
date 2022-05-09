#!/usr/bin/env bash

# Variables
CONFIG_PATH=${CONFIG_PATH:-'/data/config'}
DATA_DIR=${DATA_DIR:-'/data'}
IMAGE=${IMAGE:-'docker.io/frozenfoxx/twitchandtear:latest'}
RESTART=${RESTART:-'always'}

# Functions

## Install the container
install_container()
{
  echo "Setting up container..."
  podman pull ${IMAGE}
}

## Run the container
run_container()
{
  echo "Running the container..."

  source ${CONFIG_PATH}

  podman run -it \
    -d \
    --restart=${RESTART} \
    -v ${DATA_DIR}/wads:/wads:ro \
    -e CHANNELS \
    -e CLIENT_ID \
    -e CLIENT_SECRET \
    -e OAUTH_TOKEN \
    -e STREAM_KEY \
    -e TARGET_HOST \
    --name='twitchandtear' \
    ${IMAGE}
}

## Stop the container
stop_container()
{
  echo "Stopping the container..."
  podman kill twitchandtear
  echo y | podman container prune
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
  echo "    IMAGE                  the image to pull (default: 'docker.io/frozenfoxx/twitchandtear:latest')"
  echo "    RESTART                the restart policy for the container (default: 'always')"
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
