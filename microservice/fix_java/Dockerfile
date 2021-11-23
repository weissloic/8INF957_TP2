#
# Build stage
#
FROM maven:latest as builder
COPY src /home/api/src
COPY pom.xml /home/api
RUN mvn -f /home/api/pom.xml clean package

#
# Package stage
#
FROM openjdk:17
COPY target/api-0.0.1-SNAPSHOT.jar api-0.0.1-SNAPSHOT.jar
EXPOSE 8083
ENTRYPOINT ["java","-jar","/api-0.0.1-SNAPSHOT.jar"]