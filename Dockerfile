FROM ubuntu

ENV TCONF=/tconf
ENV DEVICE=docker

RUN apt-get update && apt-get install -y \
    emacs \
    build-essential \
    git

RUN git clone https://github.com/timstclair/tconf.git $TCONF && \
    tconf/setup.sh
