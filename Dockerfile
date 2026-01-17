# Use official Tomcat 9 image
FROM tomcat:9.0

# Maintainer info
LABEL maintainer="darshansv <darshansv1711999@gmail.com>"

# Remove default Tomcat webapps to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# ARG for WAR file path (passed from Jenkins)
ARG WAR_FILE

# Copy WAR from build context (target folder) to Tomcat
COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8081

# Start Tomcat
CMD ["catalina.sh", "run"]
