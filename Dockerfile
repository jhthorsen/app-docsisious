# jhthorsen/app-docsisious
#
# BUILD: docker build --no-cache --rm -t jhthorsen/app-docsisious .
# RUN:   docker run -it --rm -p 8080:3000 jhthorsen/app-docsisious
FROM alpine:3.5
MAINTAINER jhthorsen@cpan.org

RUN apk add -U perl perl-io-socket-ssl \
  && apk add -t builddeps build-base curl perl-dev wget \
  && wget -q -O - https://github.com/jhthorsen/app-docsisious/archive/master.tar.gz | tar xvz \
  && curl -L https://cpanmin.us | perl - App::cpanminus \
  && cpanm -M https://cpan.metacpan.org --installdeps ./app-docsisious-master \
  && apk del builddeps curl wget \
  && rm -rf /root/.cpanm /var/cache/apk/*

ENV DOCSIS_STORAGE /data
ENV MOJO_MODE production

EXPOSE 8080

ENTRYPOINT ["/app-docsisious-master/script/docsisious", "prefork", "-l", "http://*:8080"]
