# Start from the amazoncorretto image
FROM amazoncorretto
# Set /usr/src as the location for execution of The remaining instructions
WORKDIR /usr/src
# Copy all files from current linux directory to Docker workdir 
COPY . .
# Execute the ./mvrw package
RUN ./mvnw package
# Assign CMD in docker run to "java", "-jar", "./target/docker-example-1.1.3.jar"
CMD ["java", "-jar", "./target/docker-example-1.1.3.jar"]
# Expose port 8080
EXPOSE 8080
