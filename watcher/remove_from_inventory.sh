#!/bin/sh
#  oc observe services -a '{ .metadata.name }' -a '{ .spec.selector.name}' \
#		--delete ./remove_from_inventory.sh \
#			-- ./add_to_inventory.sh
if [[ $4 == nodejs-* ]]; then
	service=$3
	sed -i.bak "/${service}/d" /var/lib/haproxy/conf/custom_https.map
fi
