FROM node:6

RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated ruby ruby-dev build-essential && \
    gem install bundler -v 2.1.4 && \
    gem install ffi -v 1.15.5 && \
    gem install rb-inotify -v 0.9.10 && \
    gem install compass -v 1.0.3

WORKDIR /usr/src/app

COPY package.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["gulp"]