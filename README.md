# copiador.sh

Script de Bash para cópia de arquivos locais para o Google Drive utilizando [rclone](https://rclone.org/).

## 📋 Descrição

Este script permite a cópia automatizada de um arquivo local para uma pasta específica na raiz de um drive remoto configurado com `rclone`.

## ⚙️ Requisitos

- [rclone](https://rclone.org/) instalado e devidamente configurado com um `remote`.
- Permissões adequadas de execução para o script (`chmod +x copiador.sh`).

## 🧾 Uso

bash
    `./copiador.sh -file <caminho_completo_arquivo> -dir <diretorio_destino_no_drive>`
Parâmetros
-file: Caminho completo para o arquivo local a ser copiado.

-dir: Nome do diretório de destino na raiz do Google Drive.

Exemplo
bash
Copiar
Editar
./copiador.sh -file /home/usuario/documento.pdf -dir BACKUPS
Este comando irá copiar o arquivo documento.pdf para a pasta BACKUPS no Google Drive remoto previamente configurado no rclone.

## 🔧 Configuração
Por padrão, o script usa o nome do remote drive_euzebiogb. Caso seu remote tenha outro nome, modifique a variável:

bash
Copiar
Editar
REMOTE_NOME="seu_remote"

##🛠 Validações
O script realiza verificações como:

Existência do arquivo informado.

Presença de argumentos obrigatórios.

Saída de erro caso a cópia falhe.
