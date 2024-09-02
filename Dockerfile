# 1단계: 빌드 단계
FROM gradle:7.5.0-jdk17 AS builder
WORKDIR /app
COPY . .
RUN gradle build --no-daemon

# 2단계: 실행 단계
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]