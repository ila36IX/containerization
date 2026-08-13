all:
	docker compose up --build

db_connect:
	 docker exec -it srcs-mariadb-1 mariadb -u root -p${shell cat ./secrets/db_root_password.txt} -h 127.0.0.1

clean:
	docker image prune -f
	docker compose -f ./srcs/docker-compose.yml down --rmi local --volumes

