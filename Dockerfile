# Use Nginx base image
FROM nginx:alpine

# Clean default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy only html/css/js/images into nginx web folder
COPY food.html /usr/share/nginx/html/index.html
COPY food.css /usr/share/nginx/html/

# If you have images or JS, copy the whole project except CI/CD files
# COPY . /usr/share/nginx/html/

# Expose Nginx port
EXPOSE 80

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
