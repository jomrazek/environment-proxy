#!/bin/bash
#  oc observe services -a '{ .metadata.name }' -a '{ .spec.selector.name}' \
#		--delete ./remove_from_inventory.sh \
#			-- ./add_to_inventory.sh
if [[ $4 == nodejs-* ]]; then
	service=$3
	echo "Service ${service} detected. Adding to HAProxy map"
	deployment=$4
	echo "${deployment:7}" "${service}:8001" >> /var/lib/haproxy/conf/custom_https.map
	echo "Re-writing haproxy.config"
	/usr/bin/config-writer
	if [ $? -eq 0 ]; then
    	echo "Restarting HAProxy"
    	source /var/lib/haproxy/reload-haproxy.sh
	else
    	echo "Error writing HAProxy config from template. New service will not be reachable." && exit 1
	fi
else
	echo "Not an application service. Nothing to do" && exit 0
fi



