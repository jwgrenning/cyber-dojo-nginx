FROM nginx:latest
LABEL maintainer=jon@jaggersoft.com

ARG NGINX_DIR=/usr/share/nginx/html

RUN         rm -rf ${NGINX_DIR}
COPY        images ${NGINX_DIR}/images
COPY        js     ${NGINX_DIR}/js
RUN chmod -R +r ${NGINX_DIR}

ARG COMMIT_SHA
ENV SHA=${COMMIT_SHA}
RUN echo ${SHA} > ${NGINX_DIR}/sha.txt

COPY custom-port-env-subst.sh /docker-entrypoint.d
COPY nginx.conf.template      /etc/nginx/conf.d/default.conf.template
COPY gzip.conf                /etc/nginx/conf.d/gzip.conf
