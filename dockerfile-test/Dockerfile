FROM node:alpine3.13 AS build-stage
WORKDIR /app
COPY * ./
RUN npm install
RUN npm run build:akssit

FROM nginx:alpine AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY --from=build-stage /app/conf/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]
