# -------- Stage 1: Build WAR using Maven --------
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build WAR
RUN mvn clean package -DskipTests


# -------- Stage 2: Run WAR using Tomcat --------
FROM tomcat:10-jdk17

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy generated WAR from Maven stage
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

