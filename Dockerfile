FROM       ubuntu:trusty
MAINTAINER Karl Ma

#COPY sources.list /etc/apt/
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y \
    autoconf \
    automake \
    make \
    gcc \
    wget \
    vim \
    ncurses-dev \
    git \
    tig \
    libssl-dev \
    g++ \
    libexpat-dev \
    libyaml-dev \
    libgd-dev \
    pkg-config \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN wget http://erlang.org/download/otp_src_17.5.tar.gz && tar zxf otp_src_17.5.tar.gz && cd otp_src_17.5 && ./otp_build setup && make install


VOLUME /usr/local/src/ejabberd
WORKDIR /usr/local/src/ejabberd

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
