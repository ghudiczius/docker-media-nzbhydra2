FROM adoptopenjdk:11.0.11_9-jre-hotspot

ARG VERSION

RUN apt-get update && \
    apt-get --assume-yes install unzip && \
    groupadd --gid=1000 nzbhydra2 && \
    useradd --gid=1000 --home-dir=/opt/nzbhydra2 --no-create-home --shell /bin/bash --uid 1000 nzbhydra2 && \
    mkdir /config /downloads /opt/nzbhydra2 && \
    curl --location --output /tmp/nzbhydra2.zip "https://github.com/theotherp/nzbhydra2/releases/download/v${VERSION}/nzbhydra2-${VERSION}-linux.zip" && \
    unzip /tmp/nzbhydra2.zip -d /tmp/nzbhydra2 && \
    mv "/tmp/nzbhydra2/lib/core-${VERSION}-exec.jar" "/opt/nzbhydra2/nzbhydra2.jar" && \
    chown --recursive 1000:1000 /config /downloads /opt/nzbhydra2 && \
    rm --force --recursive /tmp/nzbhydra2.zip /tmp/nzbhydra2

USER 1000
VOLUME /config /downloads
WORKDIR /opt/nzbhydra2

EXPOSE 5076
CMD ["java", "-jar", "/opt/nzbhydra2/nzbhydra2.jar", "directstart", "-data=/config", "-nobrowser"]
