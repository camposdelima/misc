# Dockerfile for rundeck
# https://github.com/jjethwa/rundeck

FROM jordan/rundeck
MAINTAINER Cristiano Campos

RUN curl -L https://bootstrap.saltstack.com | sudo sh
CMD ["service salt-minion start"]
    