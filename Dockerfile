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

FROM openjdk:11
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

# Install docker
RUN dpkg -i https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/containerd.io_1.2.10-3_amd64.deb
# Clear cache
RUN apt-get clean

