# Dockerfile to test dotfiles on linux
# Build and run with: docker build -t dotfiles-test . && docker run -it dotfiles-test bash

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
                   ncurses-devel

# Add test group and user with sudoer privileges
RUN groupadd docker-group
RUN echo "%docker-group         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN useradd -g docker-group -ms /bin/bash docker
USER docker

# Add current directory (dotfiles) to home directory
WORKDIR /home/docker
ADD . /home/docker/dotfiles

# Make sure the dotfiles can be modified in the container
RUN sudo chmod a+rwx dotfiles/.bashrc
RUN sudo chmod a+rwx dotfiles/.vimrc
RUN sudo chmod a+rwx dotfiles/.tmux.conf
RUN sudo chmod a+rwx dotfiles/.inputrc

# Make links in the home directory to the dotfiles
RUN ln -svf dotfiles/.vimrc
RUN ln -svf dotfiles/.tmux.conf
RUN ln -svf dotfiles/.inputrc
RUN echo source ~/dotfiles/.bashrc >> .bashrc
RUN source ~/.bashrc

# Install tools
RUN install_tools
