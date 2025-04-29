#!/bin/bash

# --- Variáveis Padrão ---
# Nome do remote do rclone (pode ser configurado aqui ou via argumento se necessário)
REMOTE_NOME="drive_euzebiogb"

# --- Função de Ajuda ---
usage() {
  echo "Uso: $0 -file <caminho_completo_arquivo> -dir <diretorio_destino_no_drive>"
  echo "  -file: Caminho completo para o arquivo local a ser copiado."
  echo "  -dir:  Nome do diretório de destino na raiz do Google Drive (ex: OUTPUTs)."
  exit 1
}

# --- Processamento dos Argumentos da Linha de Comando ---
ARQUIVO_ORIGEM=""
PASTA_DESTINO_NOME=""

# Analisa os argumentos usando um loop while e case
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -file) # Argumento para o arquivo de origem
      ARQUIVO_ORIGEM="$2"
      shift # Move para o próximo argumento ou valor
      ;;
    -dir) # Argumento para o diretório de destino
      PASTA_DESTINO_NOME="$2"
      shift # Move para o próximo argumento ou valor
      ;;
    *) # Argumento desconhecido
      echo "Erro: Opção desconhecida: $1"
      usage
      ;;
  esac
  shift # Move para o próximo argumento ou par chave/valor
done

# --- Validação dos Argumentos ---
# Verifica se o arquivo de origem foi fornecido
if [ -z "$ARQUIVO_ORIGEM" ]; then
  echo "Erro: O argumento -file é obrigatório."
  usage
fi

# Verifica se o diretório de destino foi fornecido
if [ -z "$PASTA_DESTINO_NOME" ]; then
  echo "Erro: O argumento -dir é obrigatório."
  usage
fi

# Garante que a pasta de destino termine com /
# Remove barras extras no final e adiciona uma única barra
PASTA_DESTINO=$(echo "$PASTA_DESTINO_NOME" | sed 's:/*$::')/

# --- Verificações ---
# Verifica se o arquivo de origem existe
if [ ! -f "$ARQUIVO_ORIGEM" ]; then
  echo "Erro: Arquivo de origem '$ARQUIVO_ORIGEM' não encontrado."
  exit 1
fi

# --- Comando Rclone ---
echo "Iniciando a cópia de '$ARQUIVO_ORIGEM' para '$REMOTE_NOME:$PASTA_DESTINO'..."

# Comando rclone para copiar o arquivo usando os argumentos fornecidos
rclone copy "$ARQUIVO_ORIGEM" "$REMOTE_NOME:$PASTA_DESTINO" -P -v

# Verifica o status da cópia
if [ $? -eq 0 ]; then
  echo "Cópia concluída com sucesso!"
else
  echo "Erro durante a cópia. Verifique a saída do rclone acima."
  exit 1
fi

exit 0
