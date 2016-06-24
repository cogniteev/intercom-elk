FROM logstash:2.3.2-1

RUN setcap 'cap_net_bind_service=+ep' \
    "$(readlink -f "$(which java)")"

COPY ./conf /etc/logstash/

RUN /opt/logstash/bin/logstash-plugin install --no-verify logstash-input-intercom

CMD ["logstash", "-f", "/etc/logstash"]
