FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y bash && \
    rm -rf /var/lib/apt/lists/*

COPY filegen.sh /filegen.sh
RUN chmod +x /filegen.sh

CMD ["/filegen.sh"]