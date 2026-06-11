# ---------- Build Stage ----------
FROM node:20 AS build

WORKDIR /app

# Copy Angular package files from monorepo root context
COPY Fc_SmartStock/package*.json ./

# Install dependencies
RUN npm install

# Copy Angular source
COPY Fc_SmartStock/ ./

# Build production bundle
RUN npm run build

# ---------- Runtime Stage ----------
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist/fc-smart-stock/browser/ /usr/share/nginx/html/

# Copy custom nginx config
COPY Fc_SmartStock/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80