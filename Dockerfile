FROM alpine:3

ARG VERSION=6.26.0
ARG SHA256SUM=fc6f8ae5f64e4f17481f7e3be29a1c56949f216a998414188003eae1db20c9e5
ENV VERSION=${VERSION}
ENV SHA256SUM=${SHA256SUM}

LABEL maintainer="artur@magicgrants.org" \
      version=${VERSION} \
      org.opencontainers.image.source="https://github.com/MAGICGrants/xmrig-docker"

USER root
WORKDIR /root

RUN apk add wget jq
RUN wget https://github.com/xmrig/xmrig/releases/download/v${VERSION}/xmrig-${VERSION}-linux-static-x64.tar.gz && \
    echo "${SHA256SUM} xmrig-${VERSION}-linux-static-x64.tar.gz" | sha256sum -c && \
    tar -xzf xmrig-${VERSION}-linux-static-x64.tar.gz && \
    rm xmrig-${VERSION}-linux-static-x64.tar.gz && \
    mv xmrig-${VERSION}/xmrig /usr/local/bin/xmrig && \
    mkdir -p $HOME/.config && \
    cp xmrig-${VERSION}/config.json $HOME/.config/xmrig.json && \
    cp xmrig-${VERSION}/config.json $HOME/xmrig-config.json && \
    rm -rf xmrig-${VERSION}

ENTRYPOINT ["xmrig"]
