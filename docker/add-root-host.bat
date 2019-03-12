type %userprofile%\.ssh\id_rsa.pub | ssh root@%1 "mkdir -p -m 700 /root/.ssh; cat >> /root/.ssh/authorized_keys;"
ssh root@%1 "chmod 600 /root/.ssh/authorized_keys; sed -i 's/^\#RSAAuthentication.*$/RSAAuthentication yes/g' /etc/ssh/sshd_config;"
ssh root@%1 "sed -i 's/^\PubkeyAuthentication.*$//g' /etc/ssh/sshd_config;  echo \"PubkeyAuthentication yes\" >> /etc/ssh/sshd_config;systemctl restart sshd;"

REM NEED BE DONE BY ROOT
REM ssh %2@%3 "echo \"%2 ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers"
docker-machine create --driver generic --generic-ip-address=%1 --generic-ssh-key "%userprofile%/.ssh/id_rsa" --generic-ssh-user=root %1 
