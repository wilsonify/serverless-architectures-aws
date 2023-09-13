FROM ubuntu:22.04
RUN apt-get update && apt-get install -y iwatch
WORKDIR /usr/src/app
COPY listen.sh /usr/src/app/listen.sh
COPY emit.sh /usr/src/app/emit.sh
CMD ["./listen.sh"]