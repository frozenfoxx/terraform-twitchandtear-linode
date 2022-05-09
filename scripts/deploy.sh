#!/usr/bin/env bash

# Variables
CHANNELS=${CHANNELS:-''}
CLIENT_ID=${CLIENT_ID:-''}
CLIENT_SECRET=${CLIENT_SECRET:-''}
CONFIG_PATH=${CONFIG_PATH:-'/data/config'}
DATA_DIR=${DATA_DIR:-'/data'}
STREAM_KEY=${STREAM_KEY:-''}
TARGET_HOST=${TARGET_HOST:-''}

# Functions

## Build the configuration file
build_config_file()
{
  echo "Building config file..."

  echo <<- EOF > ${CONFIG_PATH}
  export CHANNELS="${CHANNELS}"
  export CLIENT_ID="${CLIENT_ID}"
  export CLIENT_SECRET=${CLIENT_SECRET}
  export OAUTH_TOKEN=''
  export STREAM_KEY=${STREAM_KEY}
  export TARGET_HOST=${TARGET_HOST}
EOF
}

## Create directories for the container
create_data_dirs()
{
  mkdir -p ${DATA_DIR}/wads
}

## Inform user about next steps
next_steps_message()
{
  echo "The server is installed, configured and ready to launch. Please perform the following steps to launch TwitchandTear:"
  echo " * Obtain an Oauth token and set it in ${CONFIG_PATH}"
  echo " * Run /usr/local/bin/twitchandtear_server.sh start"
}

## Display usage information
usage()
{
  echo "[Environment Variables] deploy.sh [options]"
  echo "  Environment Variables:"
  echo "    CHANNELS                    Twitch channels to connect to."
  echo "    CLIENT_ID                   a Twitch application Client ID"
  echo "    CLIENT_SECRET               a Twitch application Client Secret"
  echo "    CONFIG_PATH                 path to environment variable configuration (default: '/data/config')"
  echo "    DATA_DIR                    directory containing data files for containers (default: '/data')"
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
build_config_file
next_steps_message