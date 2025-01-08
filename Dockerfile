FROM eclipse-temurin:17.0.13_11-jre

ARG VERSION

RUN apt-get update && \
    apt-get --assume-yes install unzip && \
    groupadd --gid=1000 nzbhydra2 && \
    useradd --gid=1000 --home-dir=/opt/nzbhydra2 --no-create-home --shell /bin/bash --uid 1000 nzbhydra2 && \
    mkdir /config /downloads /opt/nzbhydra2 && \
    curl --location --output /tmp/nzbhydra2.zip "https://github.com/theotherp/nzbhydra2/releases/download/v${VERSION}/nzbhydra2-${VERSION}-amd64-linux.zip" && \
    unzip /tmp/nzbhydra2.zip -d /opt/nzbhydra2 && \
    chmod +x /opt/nzbhydra2/core && \
    chown --recursive 1000:1000 /config /downloads /opt/nzbhydra2 && \
    rm --force --recursive /tmp/nzbhydra2.zip /tmp/nzbhydra2

USER 1000
VOLUME /config /downloads
WORKDIR /opt/nzbhydra2

EXPOSE 5076
ENTRYPOINT ["/opt/nzbhydra2/code"]
CMD ["directstart", "--datafolder=/config", "--nobrowser"]
