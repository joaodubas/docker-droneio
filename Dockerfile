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

# add folder for drone.io db
RUN mkdir -p /var/lib/drone/

# configure container executiosn
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/droned"]
CMD ["-datasource", "/var/lib/drone/drone.sqlite", "-port", ":8080"]
