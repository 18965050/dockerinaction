FROM docker.vemic.com/insxyz/busybox
ENV CK_PUCK_FRONT_HOME /home/INS/ck-puck-front/target
RUN mkdir -p ${CK_PUCK_FRONT_HOME}
WORKDIR ${CK_PUCK_FRONT_HOME}
COPY target .
VOLUME ${CK_PUCK_FRONT_HOME}
