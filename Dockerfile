# Use official Tomcat 9 image
FROM tomcat:9.0

# Maintainer info
LABEL maintainer="darshansv <your-email@example.com>"

# Remove default Tomcat webapps to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# Accept WAR file as build argument
ARG WAR_FILE=gs-maven-0.1.0.war

# Copy WAR file from workspace to Tomcat webapps folder
COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

