#!/bin/sh
#  oc observe services -a '{ .metadata.name }' -a '{ .spec.selector.name}' \
#		--delete ./remove_from_inventory.sh \
#			-- ./add_to_inventory.sh
if [[ $4 == nodejs-* ]]; then
	service=$3
	echo "Service ${service} detected. Adding to HAProxy map"
	deployment=$4
	echo "${deployment:7}" "${service}:8001" >> /var/lib/haproxy/conf/custom_https.map
	/usr/bin/config-writer
	/bin/sh /var/lib/haproxy/reload-haproxy.sh
fi



