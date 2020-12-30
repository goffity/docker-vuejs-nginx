# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN yarn install
COPY . .
RUN npm run build

# development stage
FROM nginx:stable-alpine as development-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
