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

FROM openjdk:8u151-stretch
# Install docker:latest
RUN apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get -y install docker-ce=18.03.1~ce-0~ubuntu

# Clear cache
RUN apt-get clean

