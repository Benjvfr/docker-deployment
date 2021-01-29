FROM tomcat:10-jdk15-openjdk-oracle

COPY hello-world.war /usr/local/tomcat/webapps/
