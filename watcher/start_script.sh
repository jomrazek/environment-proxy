#!/bin/bash
oc observe services -a '{ .metadata.name }' -a '{ .spec.selector.name}' \
	--delete /var/lib/haproxy/watcher/remove_from_inventory.sh \
		--  /var/lib/haproxy/watcher/add_to_inventory.sh
