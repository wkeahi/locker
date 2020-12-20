FROM ubuntu:bionic-20201119

SHELL ["/bin/bash", "-c"]

#prerequisites
RUN apt-get update \
  && apt-get install -y \
  gnupg \
  ca-certificates \
  curl \
  && rm -rf /var/lib/apt/lists/*

#node
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -

#yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

#mongodb
RUN curl -sS https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - \
  && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list

#install dependencies
RUN apt-get update \
  && apt-get install -y \
  build-essential \
  nodejs \
  mongodb-org-shell \
  parallel \
  yarn \
  git \
  && rm -rf /var/lib/apt/lists/*

#redis
RUN mkdir /home/tmp \
  && curl http://download.redis.io/redis-stable.tar.gz --output /home/tmp/redis-stable.tar.gz \
  && tar xvzf /home/tmp/redis-stable.tar.gz -C home/tmp \
  && make -C /home/tmp/redis-stable \
  && cp /home/tmp/redis-stable/src/redis-cli /usr/local/bin/ \
  && chmod 755 /usr/local/bin/redis-cli

#java
RUN mkdir /opt/jdk \
  && curl https://download.java.net/java/GA/jdk14.0.2/205943a0976c4ed48cb16f1043c5c647/12/GPL/openjdk-14.0.2_linux-x64_bin.tar.gz --output /home/tmp/openjdk-14.0.2_linux-x64_bin.tar.gz \
  && tar -zxf /home/tmp/openjdk-14.0.2_linux-x64_bin.tar.gz -C /opt/jdk \
  && update-alternatives --install /usr/bin/java java /opt/jdk/jdk-14.0.2/bin/java 100 \
  && update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk-14.0.2/bin/javac 100 \
  && rm -rf /home/tmp

#sbt
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
  && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add \
  && apt-get update \
  && apt-get install -y sbt\
  && rm -rf /var/lib/apt/lists/*

#bloop
RUN curl https://github.com/scalacenter/bloop/releases/download/v1.4.6/bloop-x86_64-pc-linux --output /opt/bloop \
  && chmod +x /opt/bloop \
  && update-alternatives --install /usr/bin/bloop bloop /opt/bloop 100

#gulp, parallel
RUN yarn global add gulp-cli \
  && mkdir -p ~/.parallel && touch ~/.parallel/will-cite

COPY ["entrypoint/docker-entrypoint.sh", "entrypoint/docker-entrypoint-ws.sh", "/home/"]

RUN chmod +x /home/docker-entrypoint.sh \
  && chmod +x /home/docker-entrypoint-ws.sh

# Use UTF-8 encoding.
ENV LANG "C.UTF-8"
ENV LC_CTYPE "C.UTF-8"

WORKDIR /home
