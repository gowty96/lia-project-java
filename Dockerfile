# Maven build container 
FROM maven:3.6.3-openjdk-11 AS maven_build
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn clean package
FROM ubuntu
RUN apt-get -y update 
RUN apt-get -y install openjdk-8-jdk wget
RUN mkdir /usr/local/tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.62/bin/apache-tomcat-9.0.62.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp&& tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-9.0.62/* /usr/local/tomcat/
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
