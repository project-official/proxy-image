FROM amazoncorretto:17-alpine3.15-jdk

ARG VELOCITY_SECRET
ARG VELOCITY_VERSION=3.1.2
ARG VELOCITY_BUILD
ARG MOTD="&6========  &e&lCUBE Connect &r&a[1.9.x-1.18.x] &6  ========\n             &bMinecraft Server with Velocity"

WORKDIR /proxy

ADD ./scripts/* /proxy/

RUN wget https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY_VERSION}-SNAPSHOT/builds/${VELOCITY_BUILD}/downloads/velocity-${VELOCITY_VERSION}-SNAPSHOT-${VELOCITY_BUILD}.jar
RUN mv velocity-${VELOCITY_VERSION}-SNAPSHOT-${VELOCITY_BUILD}.jar velocity.jar

RUN sed -i 's/{motd}/${MOTD}/g' velocity.toml
RUN sed -i 's/{secret}/${VELOCITY_SECRET}/g' velocity.toml

EXPOSE 25565:25565

ENTRYPOINT [ "/proxy/run.sh" ]