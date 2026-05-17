# ---------- Build Stage ----------
FROM node:20 AS build

WORKDIR /app

# Copy only Angular package files from monorepo root context
COPY Fc_SmartStock/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the Angular project
COPY Fc_SmartStock/ ./

# Build production bundle
RUN npm run build

# ---------- Runtime Stage ----------
FROM nginx:alpine

# Remove default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy Angular build output
COPY --from=build /app/dist/fc-smart-stock /usr/share/nginx/html

EXPOSE 80