FROM maven:3.5-jdk-8 as builder
WORKDIR /iri
COPY . /iri
RUN mvn clean package

FROM openjdk:jre-slim
WORKDIR /iri
COPY --from=builder /iri/target/iri-1.4.2.2.jar iri.jar
COPY logback.xml /iri
VOLUME /iri

EXPOSE 14265 14777/udp 15777 5556

CMD ["/usr/bin/java", "-jar", "iri.jar", "-p", "14265", "-u", "14777", "-t", "15777", "$@"]
