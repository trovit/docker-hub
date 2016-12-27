FROM node:7.3-slim

ENV HUBOT_OWNER 'Trovit'
ENV HUBOT_NAME 'Sasha'
ENV HUBOT_EMAIL 'sasha@trovit.com'
ENV HUBOT_DESCRIPTION 'Sasha bot.'
ENV HUBOT_ADAPTER 'slack'

COPY scripts /app/scripts

RUN  npm install -g yo generator-hubot \
    && npm install \
        hubot-slack \
        hubot-redis-brain --save \
    && chown -R node:node /app

WORKDIR /app

USER node
RUN yo hubot --owner="${HUBOT_OWNER} <${HUBOT_EMAIL}>" --name="${HUBOT_NAME}" --description="${HUBOT_DESCRIPTION}" --adapter="${HUBOT_ADAPTER}" \
    && rm hubot-scripts.json


ENTRYPOINT ["/bin/sh", "-c", "bin/hubot -a slack -n '${HUBOT_NAME}'"]
