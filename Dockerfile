FROM ubuntu:xenial

LABEL maintainer="52430642+regulad@users.noreply.github.com"

# Install required packages
RUN apt-get update && apt-get install wget gettext-base moreutils -y

# Download the client, install it, and remove the downloaded file
RUN wget https://www.dynu.com/support/downloadfile/31 -qO dynuiuc.deb
RUN dpkg -i dynuiuc.deb
RUN rm dynuiuc.deb

# Set default ENV for config
ENV IPV4=true
ENV IPV6=true
ENV POLLINTERVAL=120
ENV DEBUG=false
ENV QUIET=false

# Copy & setup config
RUN mkdir -p /etc/dynuiuc/
COPY ./dynuiuc.conf dynuiuc-template.conf

# Create log & Send to docker
RUN touch /var/log/dynuiuc.log
RUN ln -sf /dev/stdout /var/log/dynuiuc.log

# Copy entrypoint script
COPY ./docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh

# Start Dynuiuc
ENTRYPOINT [ "./docker-entrypoint.sh" ]

# Configure Healthcheck
HEALTHCHECK CMD [ "ps", "cax", "|", "grep", "dynuiuc" ]
