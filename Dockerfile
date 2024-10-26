FROM node:20 AS builder

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

FROM node:20

WORKDIR /app

COPY package*.json .
COPY --from=builder /app/build .

CMD [ "node", "index.js" ]