FROM node
ARG branch
ARG hash
ARG dir_log
LABEL maintainer="Fedorov Anton"
LABEL branch=$branch
LABEL commit=$hash
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
USER node
WORKDIR /home/node/app
RUN npm install
COPY . .
VOLUME ${dir_log}
RUN ln -sf /dev/stdout ${dir_log}/file.log
EXPOSE 80
CMD ["node", "index.js"]
