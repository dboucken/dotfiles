# Dockerfile to test dotfiles on linux
# Build and run in dotfiles directory with:
#   docker build -t dotfiles-test -f scripts/Dockerfile . && docker run -it dotfiles-test bash

# Use latest centos
FROM centos:latest

# Install needed packages
RUN yum install -y sudo \
                   which \
                   git \
                   gcc \
                   make \
                   autoconf \
                   automake \
                   pkg-config \
                   libevent-devel \
                   ncurses-devel \
                   wget \
                   curl

# Add test group and user with sudoer privileges
RUN groupadd docker-group
RUN echo "%docker-group         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN useradd -g docker-group -ms /bin/bash docker
USER docker

# Add current directory (dotfiles) to home directory
WORKDIR /home/docker
ADD . /home/docker/dotfiles
