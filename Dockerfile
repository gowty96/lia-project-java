# Maven build container 
FROM maven:3.6.3-openjdk-11 AS maven_build
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package
FROM tomcat:8.0
COPY --from=maven_build /tmp/target/java-web-app-1.0.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
