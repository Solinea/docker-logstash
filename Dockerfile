# vim:set ft=dockerfile:
# Copyright 2015 Solinea, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM solinea/openjdk:jre7

MAINTAINER Luke Heidecke <luke@solinea.com>

# Download and install Public Signing Key
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net \
                --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4

ENV LOGSTASH_MAJOR 1.5
ENV LOGSTASH_VERSION 1:1.5.4-1

RUN echo "deb http://packages.elasticsearch.org/logstash/${LOGSTASH_MAJOR}/debian stable main" \
  > /etc/apt/sources.list.d/logstash.list

RUN apt-get update -y -q -q \
  && apt-get install --no-install-recommends -y -q logstash=$LOGSTASH_VERSION \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH /opt/logstash/bin:$PATH

COPY docker-entrypoint.sh /

RUN chown -R logstash:logstash /etc/logstash \
  && chown -R logstash:logstash /opt/logstash \
  && chown logstash:logstash /docker-entrypoint.sh \
  && chmod 755 /docker-entrypoint.sh

VOLUME /etc/logstash/conf.d

USER logstash

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["logstash", "agent"]
