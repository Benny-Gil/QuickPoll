FROM nginx:1.25-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=frontend:latest /app/dist /usr/share/nginx/html