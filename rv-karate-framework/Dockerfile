FROM maven:3.8.6-jdk-11

WORKDIR /usr/src/app

COPY pom.xml /usr/src/app
COPY ./src/test/java /usr/src/app/src/test/java

#folosesc aici CMD daca NU folosesc docker-compose.yml
#CMD mvn test

# docker build -t karatetest .
#docker run -it karatetest