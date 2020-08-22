FROM node
LABEL maintainer="Fedorov Anton"
LABEL branch="$branch"
LABEL hash="$hash"
COPY index.js $HOME/
EXPOSE 80
CMD ["node", "index.js"]
