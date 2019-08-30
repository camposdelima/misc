# Dockerfile for rundeck
# https://github.com/jjethwa/rundeck

FROM jordan/rundeck
MAINTAINER Cristiano Campos

RUN echo "rundeck ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && cat /etc/sudoers 

RUN cd /opt/rundeck-plugins/ && \
	curl -L https://github.com/rundeck-plugins/http-step/releases/download/1.0.11/http-step-1.0.11.jar -o /var/lib/rundeck/libext/Rundeck-Http-Step-1.0.11.jar && \
	curl -L https://github.com/rundeck-plugins/git-resource-model/releases/download/1.0.0/git-resource-model-1.0.0.jar -o /var/lib/rundeck/libext/git-resource-model-1.0.0.jar && \
	curl -L https://github.com/rundeck-plugins/rundeck-azure-plugin/releases/download/1.0.3/azure-plugin-1.0.3.jar -o /var/lib/rundeck/libext/azure-plugin-1.0.3.jar \
	curl -L https://github.com/rundeck-plugins/docker/releases/download/1.4.1/docker-container-1.4.1.zip -o /var/lib/rundeck/libext/docker-container-1.4.1.zip
	
RUN sudo apt-get update && sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg -y
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
RUN AZ_REPO=$(lsb_release -cs) && \
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
	sudo tee /etc/apt/sources.list.d/azure-cli.list
RUN sudo apt-get update && sudo apt-get install azure-cli -y
RUN sudo az aks install-cli