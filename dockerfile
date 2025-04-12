FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

COPY pom.xml mvnw ./
COPY .mvn/ .mvn
RUN ./mvnw dependency:go-offline

COPY src ./src

EXPOSE 8080 5005

CMD ["./mvnw", "spring-boot:run", "-Dspring-boot.run.jvmArguments=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"]