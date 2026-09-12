FROM ubuntu:24.04

WORKDIR /app

COPY system_monitor.sh .
COPY config.conf .

RUN chmod +x system_monitor.sh

CMD ["./system_monitor.sh"]
