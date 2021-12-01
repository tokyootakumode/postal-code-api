FROM node:16.13-buster-slim

COPY index.js index.js
COPY api/v1 api/v1
COPY lib lib
COPY package.json package.json
RUN npm install --production

CMD [ "node", "index.js"]
