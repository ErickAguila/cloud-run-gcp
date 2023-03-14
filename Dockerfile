FROM node:14-alpine AS build-env
WORKDIR /app
COPY package*.json ./
RUN npm i
COPY . .
RUN npm run build --prod

FROM nginx:1.13.9-alpine
COPY --from=build-env /app/dist/test-gcp/ /usr/share/nginx/html
COPY /nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80