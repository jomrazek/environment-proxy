FROM openshift/origin

COPY config-writer /usr/bin/config-writer

RUN INSTALL_PKGS="haproxy" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all && \
    mkdir -p /var/lib/haproxy/router/{certs,cacerts} && \
    mkdir -p /var/lib/haproxy/{conf,run,bin,log} && \
	touch  /var/lib/haproxy/conf/custom_{http,https}.map && \
    setcap 'cap_net_bind_service=ep' /usr/sbin/haproxy


COPY . /var/lib/haproxy/

RUN  chmod -R 777 /var && \
	 chmod 777 /usr/bin/config-writer

LABEL io.k8s.display-name="OpenShift Origin HAProxy Router" \
      io.k8s.description="This is a component of OpenShift Origin and contains an HAProxy instance that automatically exposes services within the cluster through routes, and offers TLS termination, reencryption, or SNI-passthrough on ports 80 and 443."

USER 1001
EXPOSE 80 443

WORKDIR /var/lib/haproxy/conf
ENV TEMPLATE_FILE=/var/lib/haproxy/conf/haproxy-config.template \
    RELOAD_SCRIPT=/var/lib/haproxy/reload-haproxy

ENTRYPOINT ["/bin/bash", "-c", "/var/lib/haproxy/watcher/start_script.sh"]



