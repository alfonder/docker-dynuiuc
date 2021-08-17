FROM alpine:3.14

LABEL org.opencontainers.image.authors="fomichev.ru@gmail.com"

# Install required packages
RUN apk update && apk upgrade && \
    apk --no-cache add -t deps wget rpm && \
    apk --no-cache add procps gettext libc6-compat libgcc libstdc++

# Download the client, install it, and remove the downloaded file
RUN wget https://www.dynu.com/support/downloadfile/30 -qO dynuiuc.rpm && \
    rpm -i --nodeps dynuiuc.rpm && \
    rpm -q --qf "%{VERSION}" dynuiuc.rpm > VERSION.txt  && \
    rm dynuiuc.rpm && \
    apk del --purge deps && rm -rf /tmp/* /var/cache/apk/*

# Set default ENV for config
ENV IPV4=true \
    IPV6=true \
    POLLINTERVAL=120 \
    DEBUG=false \
    QUIET=false

# Copy & setup config
RUN mkdir -p /etc/dynuiuc/ && \
    mv VERSION.txt /etc/dynuiuc/
COPY ./dynuiuc.conf dynuiuc-template.conf

# Create log & Send to docker
RUN touch /var/log/dynuiuc.log && \
    ln -sf /dev/stdout /var/log/dynuiuc.log

# Copy entrypoint script
COPY ./docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh

# Start Dynuiuc
ENTRYPOINT [ "./docker-entrypoint.sh" ]

# Configure Healthcheck
HEALTHCHECK CMD [ "pidof", "dynuiuc" ]
