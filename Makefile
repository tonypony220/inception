SHELL = /bin/bash

img = img_nginx

#	docker-compose rm
all:
	docker-compose -f srcs/docker-compose.yml up 
b:
	docker-compose -f srcs/docker-compose.yml build 
deldata:
	#rm -rf /data/mysql		
	#rm -rf /data/html		
	docker-compose -f srcs/docker-compose.yml down --volumes
	docker volume rm $$(docker volume ls -q)
cl: 
	docker rmi -f $$(docker images --filter "dangling=true" -q)
prune: 
	docker system prune
	docker rmi -f $$(docker images -aq)
	-docker network prune -f
	-docker rmi -f $$(docker images --filter dangling=true -qa)
	-docker volume rm $$(docker volume ls --filter dangling=true -q)
	-docker rmi -f $$(docker images -qa)
	
