FROM eclipse-temurin:17.0.15_6-jre

ARG VERSION

ADD init /init

RUN apt-get update && \
    apt-get --assume-yes install unzip && \
    groupmod --gid=1000 --new-name nzbhydra2 ubuntu && \
    usermod --comment "" --gid=1000 --home=/opt/nzbhydra2 --login nzbhydra2 --move-home --shell /bin/bash --uid 1000 ubuntu && \
    mkdir /config /downloads && \
    curl --location --output /tmp/nzbhydra2.zip "https://github.com/theotherp/nzbhydra2/releases/download/v${VERSION}/nzbhydra2-${VERSION}-amd64-linux.zip" && \
    unzip /tmp/nzbhydra2.zip -d /opt/nzbhydra2 && \
    chmod +x /opt/nzbhydra2/core && \
    chown --recursive 1000:1000 /config /downloads /opt/nzbhydra2 && \
    rm --force --recursive /tmp/nzbhydra2.zip /tmp/nzbhydra2

USER 1000
VOLUME /config /downloads
WORKDIR /opt/nzbhydra2

EXPOSE 5076
ENTRYPOINT ["/init"]
CMD ["directstart", "--datafolder=/config", "--nobrowser"]
