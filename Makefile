NAME=fuelphp
VERSION=v1.8
DOCKER_RUN_OPTIONS= \
	--privileged \
	--net=docker-lan \
	--ip=192.168.100.104 \
	-p 3307:3306 \
	-v `pwd`/mysql:/var/lib/mysql \
	-v `pwd`/src:/var/www/server

include docker.mk
