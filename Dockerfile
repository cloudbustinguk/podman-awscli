FROM centos:centos8

LABEL maintainer="Danny Webster <dsw@cloudbusting.io>"

ENV AWSCLI_VERSION=1.19.72 \
    DNF_OPTS="-y --setopt=install_weak_deps=False --setopt=tsflags=nodocs" \
    PIP_OPTS="--force-reinstall --no-cache-dir"

RUN dnf install ${DNF_OPTS} python38 python3-pip podman && \
    dnf -y clean all && \
    pip3 install ${PIP_OPTS} awscli==${AWSCLI_VERSION}

CMD [ "/bin/bash" ]
