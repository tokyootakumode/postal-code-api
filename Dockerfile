FROM node:16.13-buster-slim

WORKDIR /home/node/app
COPY index.js .
COPY lib lib
COPY package.json .
COPY gulpfile.js .
RUN npm install && npm run build && npm prune --production

CMD [ "node", "index.js"]