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

RUN wget http://erlang.org/download/otp_src_19.3.tar.gz && tar zxf otp_src_19.3.tar.gz && cd otp_src_19.3 && ./otp_build setup && make install
#COPY otp_src_19.3 /otp_src_19.3
#RUN cd /otp_src_19.3 && ./otp_build setup && make install

RUN adduser ejabberd
#COPY --chown=ejabberd:ejabberd ejabberd /ejabberd
ADD --chown=ejabberd:ejabberd https://github.com/startalkIM/ejabberd.git
RUN mkdir /startalk && chown -R ejabberd:ejabberd /startalk
WORKDIR /ejabberd
USER ejabberd
RUN cd /ejabberd && ./configure --prefix=/startalk/ejabberd --enable-pgsql --enable-full-xml \
    && make clean && make install
COPY --chown=ejabberd:ejabberd ejabberd/ejabberd.yml.qunar /startalk/ejabberd/etc/ejabberd/ejabberd.yml
COPY --chown=ejabberd:ejabberd ejabberd/ejabberdctl.cfg.qunar /startalk/ejabberd/etc/ejabberd/ejabberdctl.cfg

EXPOSE 1883 4369-4399 5202 5222 5269 5280 5443

ENTRYPOINT ["/startalk/ejabberd/sbin/ejabberdctl"]
CMD ["foreground"] 
