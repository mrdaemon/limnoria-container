FROM debian:9 AS build

RUN apt-get update && apt-get install -y \
    build-essential \
    fakeroot \
    devscripts \
    dh-python \
    python-dev \
    python-pip \
    python-setuptools

RUN mkdir -p /build/limnoria
WORKDIR /build/limnoria

COPY limnoriasrc .

RUN make builddeb_py2

FROM debian:9-slim

LABEL maintainer="Alexandre Gauthier <alex@lab.underwares.org>" \
      description="Fork of the robust and user-friendly Python IRC bot Supybot."

VOLUME /opt/limnoria

# Install runtime dependencies, remove apt cache
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-simplejson \
    python-feedparser \
    python-sqlite3 \
    python-twisted-core \
    python-twisted-names \
    python-dictclient \
    python-da && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# FIXME: This leaves the giant deb on disk. Removing it would leave it
# inside an intermediate layer anyways.
COPY --from=build /build/limnoria*.deb /tmp
RUN dpkg --install /tmp/limnoria*.deb

WORKDIR /opt/limnoria






