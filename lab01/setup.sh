#!/usr/bin/env bash
# Lab01 node setup script

# Install Docker CE
yum install -y \
  yum-utils \
  device-mapper-persistent-data \
  lvm2

docker_repo_url="https://download.docker.com/linux/centos/docker-ce.repo"
yum-config-manager --add-repo "${docker_repo_url}"

docker_package="docker-ce-17.12.1.ce-1.el7.centos"
yum makecache fast && yum install -y "${docker_package}"

# Start the Docker daemon
systemctl enable docker
systemctl start docker

# Build the greetingd Docker image
docker build -t greetingd:1.0.0 .