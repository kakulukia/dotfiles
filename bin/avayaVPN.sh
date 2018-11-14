#!/bin/bash
echo -------------------------------
echo Setting git config to use proxy: http://127.0.0.1:8888
echo
echo Use the same proxy settings in your browser if you want to browse through the vpn
echo
echo ------
git config --global http.proxy http://127.0.0.1:8888
docker run -e VPN_URL=https://ara-emea1.avaya.com/mfa-employee -e OPENCONNECT_OPTIONS=--servercert\ pin-sha256:Bn2zdjgJQOMtZUr9DB+l5+jy+joQhD8nR7Q/NMNMQKc= -e AUTH_GROUP=MFA\ Default\ VPN\ Domain --name pulsevpn --privileged=true -p 127.0.0.1:8888:8888 --rm -it 683785103570.dkr.ecr.eu-central-1.amazonaws.com/avaya/vpnproxy
echo Unsetting git proxy
git config --global --unset http.proxy
