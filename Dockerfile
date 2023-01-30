FROM maven:3.8.7-eclipse-temurin-17-alpine as build-ms-iclab

RUN mkdir -p /app
COPY . /app
WORKDIR /app

RUN \
    mvn clean compile -e && \
    mvn clean test -e && \
    mvn clean package -e

FROM maven:3.8.7-eclipse-temurin-17-alpine as main
COPY --from=build-ms-iclab /app/build /app

WORKDIR /app
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "DevOpsUsach2020-0.0.1.jar"]