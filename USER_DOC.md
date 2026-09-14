# User Guide

Instructions for running and accessing the Inception services.

## Services

* **Nginx:** Serves the main site over HTTPS on port `443`.
* **WordPress:** Powers the site and admin panel.
* **MariaDB:** Stores site data.
* **Redis:** Caches database queries in memory on port `6379`.
* **FTP:** Direct file uploads on ports `21` and `21000-21010`.
* **Adminer:** Web GUI for the database.
* **Portioned:** Docker dashboard
* **Static Site:** A standalone static web page.

## Start & Stop

* **Start:** `make`
* **Stop:** `make down`
* **Reset & wipe data:** `make clean`

## Service URLs

* **Website:** https://aljbari.42.fr
* **WordPress Admin:** https://aljbari.42.fr/wp-admin/
* **Static Site:** http://aljbari.42.fr/game
* **Adminer:** http://aljbari.42.fr/adminer
* **Portainer:** http://aljbari.42.fr/portainer
* **FTP:** `ftp -p liri@aljbari.42.fr` (port `21`)

## Credentials

* Non-sensitive settings (usernames, database names) live in `srcs/.env`.
* Passwords use Docker secrets:

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

## Health Checks

* Run `docker ps` to ensure all containers are running.
* In WordPress, check **Settings > Redis** to confirm the status is "Connected" and "Writeable".
