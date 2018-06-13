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

ARG user="iterate"

RUN groupadd -r $user && useradd --no-log-init -m -r -g $user $user

USER $user

# We make it before WORKDIR so that it
# has the right permissions of our iterate user
RUN mkdir /home/$user/application

WORKDIR /home/$user/application

# Variable expansion doesn't work
# here yet, so need to hardcode. -1 to Docker
ADD --chown=iterate:iterate ./package.json  .

ADD --chown=iterate:iterate ./yarn.lock .

ADD --chown=iterate:iterate ./src ./src

ADD --chown=iterate:iterate ./public ./public

RUN yarn

CMD yarn start
