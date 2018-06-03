FROM debian:jessie-20171210 as build

LABEL maintainer="Edgar Aroutiounian <edgar.factorial@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -qq -y install curl build-essential apt-utils && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get install -y nodejs

RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn

ENV user="iterate"

RUN groupadd -r $user && useradd --no-log-init -m -r -g $user $user

ADD ./package.json .

ADD ./yarn.lock .

ADD ./src .

USER $user

WORKDIR /home/$user/application

CMD yarn && yarn build && cat build/asset-manifest.json
