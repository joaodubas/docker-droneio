# drone.io continuous integration
#
# VERSION: see `TAG`
FROM ubuntu:14.04
MAINTAINER Joao Paulo Dubas "joao.dubas@gmail.com"

# update system and install needed deps
RUN apt-get -y -qq --force-yes update \
    && apt-get -y -qq --force-yes install wget

# install drone.io
RUN cd /tmp \
    && wget http://downloads.drone.io/latest/drone.deb \
    && dpkg -i drone.deb

# configure container executiosn
VOLUME ["/var/run/docker.sock", "/usr/bin/docker"]
EXPOSE 80 8080
ENTRYPOINT ["/usr/local/bin/droned"]
