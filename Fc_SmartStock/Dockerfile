# Build stage
FROM node:18 AS build

WORKDIR /app

COPY Fc_SmartStock/package*.json ./
RUN npm install

COPY Fc_SmartStock/ ./
RUN npm run build

# Runtime stage
FROM nginx:alpine

COPY --from=build /app/dist/fc-smart-stock /usr/share/nginx/html

EXPOSE 80