# vim:set ft=dockerfile:

FROM solinea/debian

MAINTAINER Luke Heidecke <luke@solinea.com>

RUN pkgList=' \
    python2.7 \
  ' \
  && apt-get update -y -q -q \
  && apt-get install --no-install-recommends -y -q $pkgList \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
