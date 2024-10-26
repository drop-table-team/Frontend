FROM node:20 AS builder

WORKDIR /app

COPY package*.json .

RUN mpn install

COPY . .

RUN npm run build

FROM node:20

WORKDIR /app

COPY --from=builder /app/build build/
COPY --from=builder /app/node_modules node_modules/

CMD [ "node", "build/index.js" ]