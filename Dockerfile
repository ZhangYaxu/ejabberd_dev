FROM       ubuntu:trusty
MAINTAINER Karl Ma

COPY sources.list /etc/apt/
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
    mlocate \
    && rm -rf /var/lib/apt/lists/*

#RUN mkdir /var/run/sshd

#RUN echo 'root:root' |chpasswd

#RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
#RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

#RUN wget http://erlang.org/download/otp_src_19.3.tar.gz && tar zxf otp_src_19.3.tar.gz && cd otp_src_19.3 && ./otp_build setup && make install
COPY otp_src_19.3 /otp_src_19.3
RUN cd /otp_src_19.3 && ./otp_build setup && make install

COPY ejabberd /ejabberd
#VOLUME /ejabberd
WORKDIR /ejabberd

#COPY ejabberd /ejabberd
RUN addgroup ejabberd --gid 9000 \
 && adduser --shell /bin/sh --disabled-login --disabled-password --gid 9000 ejabberd --uid 9000 
#RUN addgroup ejabberd --gid 9000 \
# && adduser --uid 9000 --shell /bin/sh --gid 9000 --disabled-login ejabberd 
RUN cd /ejabberd && ./configure --prefix=/startalk/ejabberd --enable-pgsql --enable-full-xml && 
#CMD    ["/usr/sbin/sshd", "-D"]
