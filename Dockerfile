FROM python:2.7-slim-stretch

LABEL maintainer="Alexandre Gauthier <alex@lab.underwares.org>" \
      description="Fork of the robust and user-friendly Python IRC bot Supybot."

# Default environment variables
ENV LIMNORIA_HOME /opt/limnoria
ENV LIMNORIA_CONFIG "supybot.conf"

# Install System Runtime Dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
      dnsutils \
      gnupg2 && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create directories
RUN mkdir -p /opt/limnoria
VOLUME /opt/limnoria

# Fetch requirements from limnoria master and install
ADD https://raw.githubusercontent.com/ProgVal/Limnoria/master/requirements.txt /usr/src/app/requirements.txt
RUN python -m pip install --upgrade pip && \
      pip install --no-cache-dir --upgrade -r /usr/src/app/requirements.txt

# Install limnoria from pip
# FIXME: This needs to be reasonably burstable.
RUN pip install --upgrade limnoria

# Install startup script and ensure permissions are correct
COPY runlimnoria.sh /
RUN chmod +x /runlimnoria.sh

# Expose built in webserver port
EXPOSE 8080

CMD ["/runlimnoria.sh"]
