FROM node:20

WORKDIR /app

COPY main.js .

EXPOSE 8080

ENTRYPOINT ["node", "main.js"]
