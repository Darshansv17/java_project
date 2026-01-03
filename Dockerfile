# Use official Tomcat 9 image
FROM tomcat:9.0

# Maintainer info
LABEL maintainer="darshansv <your-email@example.com>"

# Remove default Tomcat webapps to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from Maven target to Tomcat webapps folder
ARG WAR_FILE=target/gs-maven-0.1.0.war
COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
