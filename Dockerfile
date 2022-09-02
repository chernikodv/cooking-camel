FROM openjdk:11-jre
ADD /target/cooking-camel-*.jar /app.jar
CMD exec java -jar /app.jar
