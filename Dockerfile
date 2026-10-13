# ---------- Stage 1: Build ----------
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copy Maven wrapper and pom first to cache dependencies
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

# Copy source and build the jar
COPY src ./src
RUN ./mvnw clean package -DskipTests -B

# ---------- Stage 2: Run ----------
FROM eclipse-temurin:21-jre
WORKDIR /app

# Run as non-root user
RUN useradd -ms /bin/bash spring
USER spring

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

# DB_URL and DB_PASSWORD are read by application.properties at runtime
ENTRYPOINT ["java", "-jar", "app.jar"]