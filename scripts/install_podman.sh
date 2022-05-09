#!/usr/bin/env bash

# Variables
DATA_DIR=${DATA_DIR:-'/data'}
DEBIAN_FRONTEND=noninteractive
PACKAGES="podman"

# Functions

## Add registries to search
add_search_registries()
{
  echo "Adding registries to search..."
  echo <<- 'EOF' >> /etc/containers/registries.conf
  [registries.search]
  registries=["docker.io"] >> /etc/containers/registries.conf
EOF
}

## Create data directory
create_data_dir()
{
  echo "Creating data directory..."
  mkdir -p ${DATA_DIR}
}

## Install Podman packages
install_podman()
{
  echo "Installing packages..."
  apt-get install -y ${PACKAGES}
}

## Update the system packages
update()
{
  echo "Upgrading system..."
  apt-get update
  apt-get upgrade -y
}

# Logic

update
install_podman
add_search_registries
create_data_dir
