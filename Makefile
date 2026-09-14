COMPOSE_PATH = ./srcs/docker-compose.yml
DB_DATA_DIR = /home/aljbari/data/db
WP_DATA_DIR = /home/aljbari/data/wordpress

up:
	mkdir -p $(DB_DATA_DIR)
	mkdir -p $(WP_DATA_DIR)
	docker compose -f $(COMPOSE_PATH) up --build

down:
	docker compose -f $(COMPOSE_PATH) down

clean:
	docker image prune -f
	docker compose -f $(COMPOSE_PATH) down --rmi local --volumes

fclean: clean
	- docker rmi -f `docker images -qa` 2>/dev/null
	- docker volume rm `docker volume ls -q` 2>/dev/null

re: fclean
	rm -rf $(DB_DATA_DIR)
	rm -rf $(WP_DATA_DIR)
	$(MAKE) up
