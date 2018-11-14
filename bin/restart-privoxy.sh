#!/bin/bash

sudo service privoxy stop
killall -9 ssh
sudo service privoxy start
