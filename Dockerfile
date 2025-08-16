FROM node:20-slim

RUN apt-get update && \
    apt-get install -y curl git wget procps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY . .

RUN chmod +x ./blender.sh

EXPOSE 8080

CMD [ "node", "-e", "require('http').createServer((req, res) => { res.end('Hello World!'); }).listen(8080);" ]
