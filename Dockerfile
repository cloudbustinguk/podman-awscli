FROM centos:centos8

LABEL maintainer="Danny Webster <dsw@cloudbusting.io>"

ENV AWSCLI_VERSION=1.19.72 \
    DNF_OPTS="-y --setopt=install_weak_deps=False --setopt=tsflags=nodocs" \
    PIP_OPTS="--force-reinstall --no-cache-dir"

RUN dnf install ${DNF_OPTS} python38 python3-pip podman crun && \
    dnf -y clean all && \
    pip3 install ${PIP_OPTS} awscli==${AWSCLI_VERSION} && \
    echo -e '[engine]\ncgroup_manager = "cgroupfs"' >> /etc/containers/containers.conf && \
    # https://github.com/containers/podman/issues/8705
    sed -i 's|^#mount_program = "/usr/bin/fuse-overlayfs"|mount_program = "/usr/bin/fuse-overlayfs"|g' /etc/containers/storage.conf

CMD [ "/bin/bash" ]
