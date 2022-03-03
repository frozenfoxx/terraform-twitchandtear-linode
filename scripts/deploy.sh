#!/usr/bin/env bash

# Variables
CONFIG_DIR=${CONFIG_DIR:-'/data'}
DATA_DIR=${DATA_DIR:-'/data'}
STREAM_KEY=${STREAM_KEY:-''}
TARGET_HOST=${TARGET_HOST:-''}

# Functions

## Build the configuration file for docker-compose
build_docker_compose_config()
{
  echo "Completing docker-compose template..."
  envsubst '${STREAM_KEY}' '${TARGET_HOST}' < "${CONFIG_DIR}/docker-compose.yaml.tmpl" > ${DATA_DIR}/docker-compose.yaml
}

## Create directories for the container
create_data_dirs()
{
  mkdir -p ${DATA_DIR}/wads
}

## Run the docker-compose file
run_docker_compose()
{
  docker-compose -f ${DATA_DIR}/docker-compose.yaml up --detach
}

## Display usage information
usage()
{
  echo "[Environment Variables] deploy.sh [options]"
  echo "  Environment Variables:"
  echo "    CONFIG_DIR                  directory containing config files for containers"
  echo "    DATA_DIR                    directory containing data files for containers"
  echo "    STREAM_KEY                  Twitch stream key"
  echo "    TARGET_HOST                 Zandronum target"
  echo "  Options:"
  echo "    -h | --help                 display this usage information"
}

# Logic

## Argument parsing
case $1 in
  -h | --help ) usage
                exit 0
esac

create_data_dirs
build_docker_compose_config
run_docker_compose