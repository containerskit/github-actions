FROM ubuntu:21.04

ARG RUNNER_VERSION=2.263.0
ARG RUNNER_BASEURL=https://github.com/actions/runner/releases/download
ARG BUILDDIR=/opt/runner
ARG USERNAME=runner

RUN useradd -s /bin/bash -U -d ${BUILDDIR} -m ${USERNAME} \
    && apt update \
    && apt install -y curl liblttng-ust0 libkrb5-3 zlib1g libssl1.1 libicu-dev \
    && apt clean

WORKDIR ${BUILDDIR}
USER    ${USERNAME}

RUN curl -o actions-runner-linux-x64.tar.gz -L \
        ${RUNNER_BASEURL}/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64.tar.gz \
    && rm -f actions-runner-linux-x64.tar.gz

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "docker-entrypoint.sh" ]
