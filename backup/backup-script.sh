#!/bin/sh

# Data e hora atual para nomear o arquivo de backup
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Diretório de backup onde os backups serão armazenados (especificado na variável de ambiente)
BACKUP_DIR="$BACKUP_DIR"

# Nome do arquivo de backup
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

# Comando para fazer o backup
PGPASSWORD="$POSTGRES_PASSWORD" pg_dump -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -F c -b -v -f "$BACKUP_FILE" -d "$POSTGRES_DB"

# Verifica se o backup foi bem-sucedido
if [ $? -eq 0 ]; then
  echo "Backup do banco de dados concluído com sucesso em $TIMESTAMP"
else
  echo "Erro ao fazer o backup do banco de dados em $TIMESTAMP"
fi