# Use official Tomcat 9 image
FROM tomcat:9.0

LABEL maintainer="darshansv <your-email@example.com>"

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from workspace root
ARG WAR_FILE=gs-maven-0.1.0.war
COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
