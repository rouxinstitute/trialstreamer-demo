FROM node:12-alpine as build-stage
WORKDIR /app

COPY package*.json ./

RUN npm install
COPY ./ .
RUN npm run build

FROM nginx as production-stage

RUN mkdir /app

COPY --from=build-stage /app/dist /app
COPY ./branding /app/branding
COPY ./public /app/public

COPY nginx.conf /etc/nginx/nginx.conf