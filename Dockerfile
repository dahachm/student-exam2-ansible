FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
CMD tail -f /dev/null
