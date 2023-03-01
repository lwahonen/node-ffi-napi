FROM --platform=linux/arm64 node:16-alpine

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 make gcc g++ && ln -sf python3 /usr/bin/python 
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

WORKDIR /app
RUN npm i @lwahonen/ffi-napi

WORKDIR /app/node_modules/@lwahonen/ffi-napi/ 
RUN npm i -g node-gyp node-gyp-build node-addon-api prebuildify && npm i node-gyp node-gyp-build node-addon-api @lwahonen/ref-napi && rm -r prebuilds 

RUN prebuildify -t 12.22.12 -t 13.14.0 -t 14.18.3 -t 14.20.1 -t 14.21.2 -t 15.14.0 -t 16.19.0 -t 17.9.1 -t 18.12.1 -t 19.3.0 --napi --tag-armv --tag-uv --tag-libc
