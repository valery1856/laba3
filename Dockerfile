FROM debian

ADD debian.list /etc/apt/sources.list.d/
RUN apt-get update && \
    apt-get -y upgrade && \
    apt -y install nginx && \
    apt-get clean && \
    rm -rf /var/www/* && \ 
    mkdir -p /var/www/yelp.com/img && \
    chmod -R 754 /var/www/yelp.com/ && \
    useradd admin && \
    usermod -aG admin admin && \
    chown -R admin:admin /var/www/yelp.com/ && \
    sed -i 's/\/var\/www\/html/\/var\/www\/yelp.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/user www-data/user admin/g' /etc/nginx/nginx.conf
ADD index.html /var/www/yelp.com/
ADD img.jpg /var/www/yelp.com/img/
CMD ["nginx", "-g", "daemon off;"]
