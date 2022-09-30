FROM amazoncorretto:17-alpine3.15-jdk

ARG VELOCITY_SECRET
ARG VELOCITY_VERSION=3.1.2
ARG VELOCITY_BUILD

ENV VELOCITY_SECRET=${VELOCITY_SECRET}

WORKDIR /proxy

ADD ./scripts/* /proxy/

RUN wget https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY_VERSION}-SNAPSHOT/builds/${VELOCITY_BUILD}/downloads/velocity-${VELOCITY_VERSION}-SNAPSHOT-${VELOCITY_BUILD}.jar
RUN mv velocity-${VELOCITY_VERSION}-SNAPSHOT-${VELOCITY_BUILD}.jar velocity.jar
RUN chmod +x /proxy/run.sh
RUN mkdir /proxy/plugins
RUN wget https://download.luckperms.net/1453/velocity/LuckPerms-Velocity-5.4.46.jar -P /proxy/plugins
RUN wget https://github.com/ViaVersion/ViaVersion/releases/download/4.4.2/ViaVersion-4.4.2.jar -P /proxy/plugins
RUN wget https://cloud.projecttl.net/s/WFSLitPsCBrpqbQ/download/project-proxy.jar -P /proxy/plugins
RUN wget https://ci.opencollab.dev//job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/velocity/build/libs/Geyser-Velocity.jar -P /proxy/plugins
RUN wget https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/velocity/build/libs/floodgate-velocity.jar -P /proxy/plugins

RUN mkdir /proxy/plugins/luckperms
ADD ./luckperms-h2.mv.db /proxy/plugins/luckperms

RUN mkdir /proxy/plugins/Geyser-Velocity/
ADD ./geyser/config.yml /proxy/plugins/Geyser-Velocity

EXPOSE 25565:25565 19132:19132/udp

ENTRYPOINT [ "/proxy/run.sh" ]
