# Developer Guide

A quick reference for running, debugging, and maintaining the Inception stack.

## Setup

Make sure Docker and Docker Compose are installed.

1. **Storage folders:** Create `/home/aljbari/data/db` and `/home/aljbari/data/wordpress`.
2. **Environment:** Fill in your settings in `srcs/.env` (`DOMAIN_NAME`, `WORDPRESS_AUTHER_NAME`, `MARIADB_DATABASE_NAME`, etc.).
3. **Secrets:** Here is the expected files:

```
├── DEV_DOC.md
├── Makefile
├── README.md
├── secrets
│   ├── db_password.txt
│   ├── db_root_password.txt
│   ├── ftp_password.txt
│   ├── wp_admin_password.txt
│   └── wp_user_password.txt
```

## Build and Run

Services run on the `localnet` bridge and restart automatically if they crash.

* Start the stack with `make`.

## Useful Commands

* **Logs:** `docker compose logs -f`
* **Shell access:** `docker exec -it <container_name> sh`
* **Resource usage:** `docker stats`
* **Clean up everything:** `docker system prune -a`

## Persistent Storage

Data is kept safe across container restarts using bind-mounted volumes:

* **`DB`:** Mounts `/home/aljbari/data/db` to `/var/lib/mysql` in `mariadb`.
* **`wordpress_source`:** Mounts `/home/aljbari/data/wordpress` to `/var/www/html` across `wordpress`, `nginx`, and `ftp`.
