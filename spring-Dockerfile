FROM maven:3.6.0-jdk-11-slim AS build

COPY src /home/app/src

COPY pom.xml /home/app

RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:11-jre-slim

COPY --from=build /home/app/target/BMI-Calculator-App-1.0.0.jar /usr/local/lib/BMI-Calculator-App-1.0.0.jar

EXPOSE 8000

ENTRYPOINT ["java","-jar","/usr/local/lib/BMI-Calculator-App-1.0.0.jar"]
