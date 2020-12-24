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

COPY nginx.conf.template        /docker-entrypoint.d
COPY ports.env                  /docker-entrypoint.d
COPY template-port-env-subst.sh /docker-entrypoint.d

COPY gzip.conf  /etc/nginx/conf.d/gzip.conf
