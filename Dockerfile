FROM ubuntu:latest

# Install packages
RUN apt-get update

# Install ssh
RUN apt-get -y install openssh-client

# Configure ssh client
COPY id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa.pub

# Install maven 3.8.3
RUN apt install maven -y
ENV PATH /usr/share/maven/bin
RUN export PATH

# Install tomcat9
FROM tomcat:9.0-alpine
EXPOSE 8080
CMD ["catalina.sh", "run"]

FROM openjdk:16-alpine3.13
# Install docker:latest
RUN apt install docker.io

# Clear cache
RUN apt-get clean

