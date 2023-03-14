FROM node:14-alpine AS build-env
WORKDIR /app
COPY . ./
RUN npm install
RUN npm run build

FROM nginx:1.13.9-alpine
COPY --from=build-env /app/dist/test-gcp/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]