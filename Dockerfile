# iOS Buildbox

FROM ubuntu:latest
MAINTAINER Jeff Buchbinder <jeff@jbuchbinder.com>

# Build and checkout prereqs

RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
    build-essential ca-certificates \
    file git cmake clang python \
    automake autoconf libtool \
    libxml2-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install xar

RUN git clone https://github.com/mackyle/xar.git && \
    cd xar/xar && \
    ./autogen.sh && \
    make all && \
    make install && \
    cd ../.. && rm -rf xar

# Install TAPI library prerequisite
	
RUN git clone https://github.com/tpoechtrager/apple-libtapi.git && \
    cd apple-libtapi && \
    INSTALLPREFIX=/usr ./build.sh && \
    ./install.sh && \
    cd .. && rm -rf apple-libtapi

# Install ccports

RUN git clone https://github.com/tpoechtrager/cctools-port.git && \
    cd cctools-port/cctools && \
    ./configure \
        --prefix=/usr \
        --target=x86_64-apple-darwin11 \
        --with-libtapi=/usr && \
    make && \
    make install && \
    cd ../.. && rm -rf cctools-port

