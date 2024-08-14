#first build
FROM maven:3.8.6-openjdk-18-slim as build
WORKDIR /app
COPY src /app/src
COPY pom.xml /app/pom.xml
RUN mvn clean package -DskipTests
# second stage 
FROM openjdk:18-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/sample-0.0.1-SNAPSHOT.jar /app/sample-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar"]
CMD ["sample-0.0.1-SNAPSHOT.jar"]