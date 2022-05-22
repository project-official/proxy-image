FROM amazoncorretto:17-alpine3.15-jdk

ARG VELOCITY_SECRET
ARG VELOCITY_VERSION=3.1.2
ARG VELOCITY_BUILD

ENV VELOCITY_SECRET=${VELOCITY_SECRET}

WORKDIR /proxy

ADD ./scripts/* /proxy/

RUN wget https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY_VERSION}-SNAPSHOT/builds/${VELOCITY_BUILD}/downloads/velocity-${VELOCITY_VERSION}-SNAPSHOT-${VELOCITY_BUILD}.jar
RUN mv velocity-${VELOCITY_VERSION}-SNAPSHOT-${VELOCITY_BUILD}.jar velocity.jar

EXPOSE 25565:25565

ENTRYPOINT [ "/proxy/run.sh" ]