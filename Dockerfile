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

# Install openjdk
RUN apt install openjdk-8-jdk -y && \
        apt install ant -y &&
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Install docker:latest
RUN sudo apt install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install tomcat9
RUN apt install tomcat9 -y
EXPOSE 8080
CMD ["catalina.sh", "run"]
# Clear cache
RUN apt-get clean

