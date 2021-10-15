FROM busybox as builder
ENV WLS_PKG wls_dev.zip
COPY $WLS_PKG .
RUN unzip $WLS_PKG -d /wls

FROM caninjas/jdk6 as base
# MAINTAINER Cristiano Campos <cristiano.campos@outlook>
# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
ENV ORACLE_HOME /u01/oracle
ENV MW_HOME $ORACLE_HOME/weblogic
ENV WL_HOME $MW_HOME/wlserver
ENV JAVA_HOME /usr/lib/jvm/java-6-oracle

ENV ADMIN_PASSWORD welcome01
ENV ADMIN_PORT 7001
ENV USER_MEM_ARGS -Xms256m -Xmx512m -XX:MaxPermSize=1024m
ENV EXTRA_JAVA_PROPERTIES $EXTRA_JAVA_PROPERTIES -Djava.security.egd=file:///dev/urandom

# Setup required packages (unzip), filesystem, and oracle user
# ------------------------------------------------------------
RUN mkdir /u01 && \
    chmod a+xr /u01 && \
    useradd -b /u01 -m -s /bin/bash oracle 

WORKDIR $MW_HOME
# Copy packages
COPY --from=builder /wls .
COPY prepare.py .

# Change the open file limits in /etc/security/limits.conf
RUN sed -i '/.*EOF/d' /etc/security/limits.conf && \
    echo "* soft nofile 16384" >> /etc/security/limits.conf && \ 
    echo "* hard nofile 16384" >> /etc/security/limits.conf && \ 
    echo "# EOF"  >> /etc/security/limits.conf
# Change the kernel parameters that need changing.
RUN echo "net.core.rmem_max=4192608" > $ORACLE_HOME/.sysctl.conf && \
    echo "net.core.wmem_max=4192608" >> $ORACLE_HOME/.sysctl.conf && \ 
    sysctl -e -p $ORACLE_HOME/.sysctl.conf
# Adjust file permissions, go to /u01 as user 'oracle' to proceed with WLS installation
RUN chown oracle:oracle -R /u01
RUN bash ./configure.sh

ENV PATH $PATH:$MW_HOME/oracle_common/common/bin

# Root commands
USER root
RUN echo ". $MW_HOME/user_projects/domains/base_domain/bin/setDomainEnv.sh" >> /root/.bashrc && \
    echo "export PATH=$PATH:$WL_HOME/common/bin:$MW_HOME/user_projects/domains/base_domain/bin" >> /root/.bashrc

# Configuration of WLS Domain
USER oracle
RUN $WL_HOME/common/bin/wlst.sh -skipWLSModuleScanning $MW_HOME/prepare.py
RUN mkdir -p $MW_HOME/user_projects/domains/base_domain/servers/AdminServer/security && \
    echo "username=weblogic" > $MW_HOME/user_projects/domains/base_domain/servers/AdminServer/security/boot.properties && \ 
    echo "password=$ADMIN_PASSWORD" >> $MW_HOME/user_projects/domains/base_domain/servers/AdminServer/security/boot.properties && \
    echo ". $MW_HOME/user_projects/domains/base_domain/bin/setDomainEnv.sh" >> $ORACLE_HOME/.bashrc && \ 
    echo "export PATH=$PATH:$WL_HOME/common/bin:$MW_HOME/user_projects/domains/base_domain/bin" >> $ORACLE_HOME/.bashrc 

ENV PATH $PATH:$WL_HOME/common/bin:$MW_HOME/user_projects/domains/base_domain/bin:$ORACLE_HOME

# Expose default http/https ports for admin console
EXPOSE $ADMIN_PORT
VOLUME $MW_HOME/user_projects/domains/base_domain
# Define default command to start bash. 
CMD ["startWebLogic.sh"]