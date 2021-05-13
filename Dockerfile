FROM registry.access.redhat.com/ubi8/ubi

LABEL maintainer="Danny Webster <dsw@cloudbusting.io>"

ENV AWSCLI_VERSION=1.19.72 \
    DNF_OPTS="-y --setopt=install_weak_deps=False --setopt=tsflags=nodocs" \
    PIP_OPTS="--force-reinstall --no-cache-dir"

RUN dnf install podman git openssh-clients crun

RUN dnf install ${DNF_OPTS} python38 && \
    dnf -y clean all && \
    pip3 install ${PIP_OPTS} awscli==${AWSCLI_VERSION}

CMD [ "/bin/bash" ]
