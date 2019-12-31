FROM nginx:latest
LABEL maintainer=jon@jaggersoft.com

ARG NGINX_DIR=/usr/share/nginx/html

RUN         rm -rf ${NGINX_DIR}
COPY        images ${NGINX_DIR}/images
COPY traffic-light ${NGINX_DIR}/traffic-light
RUN chmod -R +r ${NGINX_DIR}

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY gzip.conf  /etc/nginx/conf.d/gzip.conf

ARG SHA
ENV SHA=${SHA}
RUN echo ${SHA} > ${NGINX_DIR}/sha.txt
