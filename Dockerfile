FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY ./target/spring-data-jdbc-on-azure-0.1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
