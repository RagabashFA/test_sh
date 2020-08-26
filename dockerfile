FROM node
ARG branch
ARG hash
ARG dir_name
LABEL maintainer="Fedorov Anton"
LABEL branch=$branch
LABEL commit=$hash
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
RUN npm install
COPY index.js .
VOLUME ${dir_name}
RUN ln -sf /dev/stdout ${dir_name}/file.log
EXPOSE 80
CMD ["node", "index.js"]
