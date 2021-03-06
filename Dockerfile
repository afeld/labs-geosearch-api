# base image
FROM pelias/baseimage

EXPOSE 3100

# Where the app is built and run inside the docker fs
ENV WORK=/opt/pelias

# Used indirectly for saving npm logs etc.
ENV HOME=/opt/pelias

WORKDIR ${WORK}
COPY . ${WORK}

# Build and set permissions for arbitrary non-root user
RUN npm install && \
  chmod -R a+rwX .

# Don't run as root, because there's no reason to (https://docs.docker.com/engine/articles/dockerfile_best-practices/#user).
# This also reveals permission problems on local Docker.
RUN chown -R 9999:9999 ${WORK}
USER 9999

# start service
CMD [ "npm", "start" ]
