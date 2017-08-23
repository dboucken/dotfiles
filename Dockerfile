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

# Make links in the home directory to the dotfiles
RUN ln -s dotfiles/.vimrc .vimrc
RUN ln -s dotfiles/.tmux.conf .tmux.conf
RUN echo source ~/dotfiles/.bashrc >> .bashrc

# Install tools
RUN mkdir tools

# Latest tmux
RUN git clone https://github.com/tmux/tmux.git tools/tmux
RUN cd tools/tmux && git checkout 2.5 && sh autogen.sh && ./configure && make && sudo make install

# Latest vim
RUN git clone https://github.com/vim/vim.git tools/vim
RUN cd tools/vim && ./configure --with-features=huge && make && sudo make install
