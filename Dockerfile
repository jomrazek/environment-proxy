FROM openshift/origin-haproxy-router:v1.3.1

USER root


RUN touch /var/lib/haproxy/conf/custom_{http,https}.map && \
	chmod -R 777 /var

COPY ./pg-custom-config.template /var/lib/haproxy/conf/haproxy-config.template

USER 1001

ENTRYPOINT ["/usr/bin/openshift-router", "--loglevel=4"]
