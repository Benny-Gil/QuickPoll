# Build stage
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app

# Copy maven files first to cache dependencies
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline

# Copy source code and build
COPY src src
RUN ./mvnw package -DskipTests

# Run stage
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:8080/api/polls || exit 1

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]