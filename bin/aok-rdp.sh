#!/bin/bash
ssh -p 2222 \
    `# ITScare (HE / BW / RPS / BVT / ITScare)` \
    -L3301:10.230.114.31:3389 \
    `# GKVI (NW / RH)` \
    -L3302:10.232.215.131:3389 \
    `# ARGE (NDS / HB / SAN)` \
    -L3303:10.232.214.20:3389 \
    `# Kubus (BY / Plus / Kubus)` \
    -L3304:10.232.214.31:3389 \
    `# BV` \
    -L3305:10.232.214.30:3389 \
    `# Systems` \
    -L3306:10.230.117.10:3389 \
    root@localhost