REM type %userprofile%\.ssh\id_rsa.pub | ssh %2@%3 "mkdir -p -m 700 /%2/.ssh; cat >> /home/%2/.ssh/authorized_keys;"
REM ssh %2@%3 "chmod 600 /home/%2/.ssh/authorized_keys; sed -i 's/^\#RSAAuthentication.*$/RSAAuthentication yes/g' /etc/ssh/sshd_config;"
REM ssh %2@%3 "sed -i 's/^\PubkeyAuthentication.*$//g' /etc/ssh/sshd_config;  echo \"PubkeyAuthentication yes\" >> /etc/ssh/sshd_config;systemctl restart sshd;"

REM NEED BE DONE BY ROOT
REM ssh %2@%3 "echo \"%2 ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers"
docker-machine create --driver generic --generic-ip-address=%3 --generic-ssh-key "%userprofile%/.ssh/id_rsa" --generic-ssh-user=%2 %1 
