# drone.io continuous integration
#
# VERSION: see `TAG`
FROM ubuntu:14.04
MAINTAINER Joao Paulo Dubas "joao.dubas@gmail.com"

# provision image
RUN echo "update system and install needed deps" \
    && apt-get -y -qq --force-yes update \
    && apt-get -y -qq --force-yes install wget libsqlite3-dev \
    && echo "install drone" \
    && cd /tmp \
    && wget http://downloads.drone.io/master/drone.deb \
    && dpkg -i drone.deb \
    && echo "add folder for drone.io db" \
    && mkdir -p /var/lib/drone/
ADD drone.toml /var/lib/drone/drone.toml

# configure container execution
EXPOSE 8080
ENV DRONE_SERVER_PORT :8080
ENTRYPOINT ["/usr/local/bin/droned"]
CMD ["--config", "/var/lib/drone/drone.toml"]
