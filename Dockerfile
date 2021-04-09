# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.159.0/containers/cpp/.devcontainer/base.Dockerfile
ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/cpp:0-${VARIANT}

ENV SOUL_VERSION=1.0.82
ENV FAUST_VERSION=2.30.5
ENV MKCERT_VERSION=1.4.3

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends vim libfreetype6-dev libasound2-dev \
    && apt-get -y install --no-install-recommends python3-numpy python3-scipy python3-matplotlib python3-setuptools \
    && apt-get -y install --no-install-recommends libncurses5-dev libncurses5 libmicrohttpd-dev pkg-config
RUN wget https://github.com/soul-lang/SOUL/releases/download/${SOUL_VERSION}/binaries-linux-combined.zip \
    && unzip binaries-linux-combined.zip \
    && mv linux/x64/soul /usr/local/bin \
    && rm -r linux \
    && rm binaries-linux-combined.zip
RUN wget https://github.com/FiloSottile/mkcert/releases/download/v${MKCERT_VERSION}/mkcert-v${MKCERT_VERSION}-linux-amd64 -O mkcert \
    && chmod +x mkcert \
    && mv mkcert /usr/local/bin \
    && mkcert -install
RUN wget https://github.com/grame-cncm/faust/releases/download/${FAUST_VERSION}/faust-${FAUST_VERSION}.tar.gz \
    && tar -xzf faust-${FAUST_VERSION}.tar.gz \
    && cd faust-${FAUST_VERSION} \
    && make && make install \
    && make clean \
    && cd .. && rm -r faust-${FAUST_VERSION} \
    && rm faust-${FAUST_VERSION}.tar.gz
