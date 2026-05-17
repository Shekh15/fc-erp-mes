# ---------- Build Stage ----------
FROM node:20 AS build

WORKDIR /app

# Copy the entire Angular project
COPY . .

# Install dependencies
RUN npm install

# Build production bundle
RUN npm run build

# ---------- Runtime Stage ----------
FROM nginx:alpine

# Remove default Nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy Angular build output
COPY --from=build /app/dist/fc-smart-stock /usr/share/nginx/html

EXPOSE 80