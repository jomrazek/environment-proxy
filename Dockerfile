FROM openshift/origin-haproxy-router:v1.3.1

USER root

COPY watcher /var/lib/haproxy/watcher

RUN touch /var/lib/haproxy/conf/custom_{http,https}.map && \
	chmod -R 777 /var

COPY ./custom-config.template /var/lib/haproxy/conf/haproxy-config.template

USER 1001

ENTRYPOINT ["/bin/bash", "-c", "/var/lib/haproxy/watcher/start_script.sh"]
