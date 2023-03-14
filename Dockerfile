FROM node:14-alpine AS build-env
WORKDIR /source

# Copy the package lock file into the container
COPY package*.json ./
# Run ci only for the production dependencies
RUN npm ci

# Copy the rest of the files into the container and build
COPY . .
RUN npm run build --prod

FROM nginx:1.13.9-alpine
COPY --from=build-env /app/dist/test-gcp/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080