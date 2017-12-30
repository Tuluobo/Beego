FROM golang:1.9.2
LABEL Tuluobo tuluobo@vip.qq.com
ENV REFRESHED_AT 2017-12-28

RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/* \
    # Fix write permissions with shared folders
    && usermod -u 1000 www-data

# beego
RUN go get github.com/astaxie/beego
RUN go get github.com/beego/bee

# Nginx
RUN rm -rf /etc/nginx/sites-available/* \
    && rm -rf /etc/nginx/sites-enabled/* \
    && rm -rf /var/www/*

COPY image-files /
WORKDIR /etc/nginx/sites-enabled
RUN ln -s /etc/nginx/sites-available/default.conf default 

WORKDIR /root
RUN chmod +x /root/start.sh
ENTRYPOINT ["/root/start.sh"]

EXPOSE 80