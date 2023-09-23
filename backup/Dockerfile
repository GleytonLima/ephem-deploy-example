FROM alpine:3.18

# Atualize o índice de pacotes e instale o cliente PostgreSQL
RUN apk update && apk add --no-cache postgresql-client

COPY backup-script.sh /backup-script.sh
RUN sed -i 's/\r$//' /backup-script.sh
RUN chmod +x /backup-script.sh

COPY crontab /etc/crontabs/root
RUN sed -i 's/\r$//' /etc/crontabs/root

# start crond with log level 8 in foreground, output to stderr
CMD ["crond", "-f"]