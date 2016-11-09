FROM docker.vemic.com/insxyz/jetty:9.3.12
COPY target ${JETTY_HOME}/webapps
COPY ck-puck.xml ${JETTY_HOME}/webapps
ENV spring.profiles.active development
USER jetty 
WORKDIR ${JETTY_HOME}
CMD ["java","-jar","/usr/local/jetty/start.jar","-Ddubbo.resolve.file=./webapps/dubbo-resolve.properties"]