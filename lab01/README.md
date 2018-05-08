# Lab01 Setup

``` bash
# Update system packages and install Git
yum update -y && yum install -y git

# Get the lab setup files
git clone https://github.com/graysonkuhns/csis-152-lab-setup.git /tmp/lab-setup

# Run the setup script
cd /tmp/lab-setup/lab01
./setup.sh
```
