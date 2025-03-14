## Build time configuraton
FROM maven:3.8-eclipse-temurin-21-alpine AS MAVEN_BUILD
MAINTAINER John MacAuley <macauley@es.net>
ENV HOME=/iri
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN mvn -f $HOME/pom.xml clean package

FROM openjdk:21-jdk

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/app.jar"]