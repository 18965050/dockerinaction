FROM docker.vemic.com/insxyz/nginx:1.11.5
EXPOSE 80
ADD ./nginx-io.conf /etc/nginx/
RUN mkdir -p /home/INS/logs/nginx/
CMD ["nginx","-c", "/etc/nginx/nginx-io.conf","-g","daemon off;"]
