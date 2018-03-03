# jhthorsen/app-docsisious
#
# BUILD: docker build --no-cache --rm -t jhthorsen/app-docsisious .
# RUN:   docker run -it --rm -p 8080:3000 jhthorsen/app-docsisious
FROM alpine:3.5
MAINTAINER jhthorsen@cpan.org

RUN apk add -U perl perl-io-socket-ssl \
  && apk add -t builddeps build-base perl-dev wget \
  && wget -q -O - https://github.com/jhthorsen/app-docsisious/archive/master.tar.gz | tar xvz \
  && apk del builddeps \
  && curl -L https://cpanmin.us | perl - App::cpanminus
  && rm -rf /root/.cpanm /var/cache/apk/*

RUN cpanm --installdeps /app-docsisious-master

ENV MOJO_MODE production
EXPOSE 3000
CMD ["daemon"]
ENTRYPOINT ["/app-docsisious-master/script/docsisious"]
