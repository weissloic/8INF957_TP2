FROM maven:latest as builder
COPY edu /edu/src
COPY pom.xml /edu/
RUN mvn -f /edu/src/pom.xml clean package

#
# Package stage
#
FROM openjdk:11
COPY target/1.0-SNAPSHOT.jar 1.0-SNAPSHOT.jar

ENTRYPOINT ["java","-jar","/1.0-SNAPSHOT.jar"]