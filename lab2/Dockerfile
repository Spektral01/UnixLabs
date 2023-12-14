FROM ubuntu:latest

VOLUME /var/lib/docker/volumes/flock_shared_volume/_data

# Копируем скрипт в образ
COPY filegen.sh /filegen.sh

# Устанавливаем права на выполнение
RUN chmod +x /filegen.sh

# Задаем команду по умолчанию
CMD ["/filegen.sh"]
