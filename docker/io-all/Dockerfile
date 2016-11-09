FROM docker.vemic.com/insxyz/java
ENV LOG_PATH /home/INS/logs/io-all
RUN mkdir -p /home/INS/io-all/target
RUN mkdir -p ${LOG_PATH}
WORKDIR /home/INS/io-all/target
COPY run.sh .
RUN chmod u+x run.sh
COPY target .
CMD ["./run.sh"]
EXPOSE 20980
EXPOSE 9009
ENTRYPOINT ["/bin/bash"]