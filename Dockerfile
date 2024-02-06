# This Dockerfile builds a frontend application using Node.js and Nginx.
# It sets up a multi-stage build process to optimize the final image size.
# The first stage uses the Node.js image to install dependencies and build the application.
# The second stage uses the Nginx image to serve the built application.

FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html