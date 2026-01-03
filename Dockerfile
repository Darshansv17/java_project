# Use official Tomcat 9 image
FROM tomcat:9.0

# Maintainer info
LABEL maintainer="darshansv <darshansv1711999@gmail.com>"

# Remove default Tomcat webapps to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# WAR file argument (passed from Jenkins)
ARG WAR_FILE=gs-maven-0.1.0.war

# Copy WAR into Tomcat webapps
COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
