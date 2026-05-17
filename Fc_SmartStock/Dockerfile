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

# Remove default nginx page
RUN rm -rf /usr/share/nginx/html/*

# IMPORTANT: copy from browser subfolder
COPY --from=build /app/dist/fc-smart-stock/browser/ /usr/share/nginx/html/

EXPOSE 80