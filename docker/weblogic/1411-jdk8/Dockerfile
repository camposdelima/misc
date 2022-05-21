from mdsol/weblogic14:latest
ENV DEBUG_FLAG=true
ENV PRODUCTION_MODE dev
ENV ADMINISTRATION_PORT_ENABLED false
ENV ORACLE_HOME /u01/oracle
ENV MW_HOME $ORACLE_HOME/weblogic
ENV WL_HOME $ORACLE_HOME/wlserver
ENV ADMIN_PASSWORD welcome1


ENV PATH $PATH:$WL_HOME/common/bin:$MW_HOME/user_projects/domains/base_domain/bin:$ORACLE_HOME
# RUN sed -i 's/<administration-port-enabled>true/<administration-port-enabled>false/g' user_projects/domains/base_domain/config/config.xml
USER root
RUN mkdir -p $ORACLE_HOME/properties/ && \
    echo "username=weblogic" > $ORACLE_HOME/properties/domain.properties && \ 
    echo "password=$ADMIN_PASSWORD" >> $ORACLE_HOME/properties/domain.properties
USER oracle

#BUG-FIX - CLEAN BACKUP AFTER DOMAIN CONFIGURATION TO AVOID LOSING CHANGES
#REF: https://stackoverflow.com/questions/64564839/weblogic-lose-changes-after-restart
RUN rm -Rf $ORACLE_HOME/user_projects/domains/base_domain/servers/domain_bak/*
VOLUME $MW_HOME/user_projects/domains/base_domain