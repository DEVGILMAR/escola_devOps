# Etapa 1: Definir a imagem base
# Usamos uma imagem oficial do Python com Alpine Linux para manter o tamanho final pequeno.
FROM python:3.13.5-alpine3.21

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
# Isso garante que os comandos subsequentes sejam executados neste diretório.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências
# Copiamos o requirements.txt primeiro para aproveitar o cache de camadas do Docker.
# Se este arquivo não mudar, o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .

# Etapa 4: Instalar as dependências
# O argumento --no-cache-dir garante que não armazenemos o cache do pip, reduzindo o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o código da aplicação para o contêiner
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada
EXPOSE 8000

# Etapa 7: Comando para iniciar a aplicação quando o contêiner for executado
# Usamos uvicorn para rodar a aplicação FastAPI, escutando em todas as interfaces de rede (0.0.0.0).
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]