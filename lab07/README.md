# Lab07 Setup

``` bash
# Create ops user
adduser ops
echo "ops:ops2018" | chpasswd
usermod -aG wheel ops

# Allow ssh auth using passwords
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
```
