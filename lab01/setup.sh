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

# Create application directories
mkdir -p \
  /etc/greetingd \
  /var/log/greetingd \
  /etc/systemd/system/greetingd.service.d

# Write the greetingd unit file
cat > /etc/systemd/system/greetingd.service <<EOF
[Unit]
Description=Greeting service
Requires=docker.service
After=docker.service

[Service]
# Start
ExecStart=/bin/docker run \
  --name greetingd \
  --env-file /etc/greetingd/greetingd.conf \
  -v /var/log/greetingd:/var/log/greetingd \
  "${GREETINGD_DOCKER_IMAGE}"

# Stop
ExecStop=/bin/docker stop greetingd
ExecPostStop=/bin/docker rm -f greetingd

# Auto restart
Restart=always
RestartSec=3
EOF

# Write greetingd unit config file
cat > /etc/systemd/system/greetingd.service.d/default.conf <<EOF
[Service]
Environment=GREETINGD_DOCKER_IMAGE=greetingd:1.0.0
EOF

# Write the service config file
cat > /etc/greetingd/greetingd.conf <<EOF
LOGGING_DIRECTORY=/var/log/greetingd
GREETING_MESSAGE=Hello, World!
GREETING_INTERVAL=5
EOF

# Start the greetingd service
systemctl start greetingd
