FROM quay.io/cogniteev/elk-logstash

RUN /opt/logstash/bin/logstash-plugin install --no-verify --version 0.0.2 logstash-input-intercom

ONBUILD ADD ./conf /etc/logstash/
