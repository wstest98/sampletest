#FROM docker.io/wsjeong/tomcat85_base:v1
FROM docker.io/wsjeong/tomcat85:v1

ARG TOMCAT_ENGIN="apache-tomcat-8.5.59"
ENV TOMCAT_PATH "${TOMCAT_ENGIN}"

USER root

ADD files/ /tmp

WORKDIR /tmp

RUN cp -a  webapp/mlbparks /usr/local/${TOMCAT_ENGIN}/webapps/    

RUN chmod -R 775 /usr/local/${TOMCAT_ENGIN}  \
 && chown -R tomcat.root /usr/local/${TOMCAT_ENGIN}/webapps  

USER tomcat
