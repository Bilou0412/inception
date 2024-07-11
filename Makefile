all: 
	@mkdir -p /home/bmoudach/data/wordpress
	@mkdir -p /home/bmoudach/data/mariadb
	@docker compose -f ./srcs/docker-compose.yml up --build -d

down:
	docker compose -f ./srcs/docker-compose.yml down

stop:
	docker compose -f ./srcs/docker-compose.yml stop

start:
	docker compose -f ./srcs/docker-compose.yml start

build:
	clear
	docker compose -f ./srcs/docker-compose.yml build

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@rm -rf /home/bmoudach/data/* || true

fclean: clean
	@docker system prune -a --volumes -f

re: clean all

.PHONY: all up down stop start build ng mdb wp clean re prune
