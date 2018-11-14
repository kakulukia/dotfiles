#!/bin/bash

bash restart-privoxy.sh

ssh \
	-o IdentitiesOnly=yes -i ~/.ssh/ept-demoportal.pem \
	-f -C -q -N -D 4000 \
	-L 4002:10.1.1.20:1433 \
	-L 4003:10.1.1.20:3389 \
	-A \
	centos@darwin.ept-solutions.com \
	&& /usr/bin/firefox -new-tab "https://10.1.1.251/" -P darwin &

# then install privoxy (one time, not part of this script)

# brew install privoxy
# echo "forward-socks5 / localhost:4000 ." >> /usr/local/etc/privoxy/config
# brew services start privoxy
