FROM node
LABEL maintainer="Fedorov Anton"
LABEL branch="$branch"
LABEL commit="$hash"
RUN npm install
WORKDIR $dir_name
VOLUME $dir_name
COPY index.js ./
EXPOSE 80
CMD ["node", "index.js"]
