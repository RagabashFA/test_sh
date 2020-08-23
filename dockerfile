FROM node
LABEL maintainer="Fedorov Anton"
LABEL branch="$branch"
LABEL hash="$hash"
COPY index.js $HOME/
VOLUME $dir_name
EXPOSE 80
CMD ["node", "index.js"]
