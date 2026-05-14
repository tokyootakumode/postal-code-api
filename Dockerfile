FROM node:24.15-slim

WORKDIR /home/node/app
COPY lib lib
COPY package.json .
COPY gulpfile.js .
RUN npm install
RUN npm install -g http-server
RUN npm run build
RUN npm prune --production

CMD [ "npm", "start" ]
