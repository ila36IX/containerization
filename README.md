*This project has been created as part of the 42 curriculum by aljbari.*

# Description

Use Docker Compose to set up a small web stack with WordPress, MariaDB, Nginx, Redis, Adminer, Portainer, FTP, and a static site. Everything is managed through a single Compose file and a Makefile to keep building and running the containers simple.

All containers talk to each other over a single Docker network. We also use volumes so your data stays safe and won't be lost if a container is removed.

Virtualization uses hypervisor which manages hardware so more than one operating system can run on it at once while Docker packages just the app and its dependencies, and shares the host machine's kernel directly which is lightweight and start faster then VMs but doesn't offer full isolation with its own OS.

Environment variables are fine for non-sensitive settings like ports and hostnames, but they leak easily through logs. Secrets are built for passwords and keys that got mounted directly in memory so they never sit exposed as plaintext.

A bridge **Docker Network** isolates containers into their own virtual network, requiring explicit port mapping to talk to the outside. **Host Network** removes that isolation entirely—the container shares the host's actual network stack, meaning zero network overhead but direct port conflicts with the host system.

"Docker Volumes" are managed entirely by Docker inside its storage directory, isolating data from direct host while "Bind Mounts" map an exact file or directory from anywhere on the host filesystem directly into the container.

# Instructions

1. Create a srcs/.env file with the required service environment variables.
2. Run `make` to build all images, and launch it.

# Resources

- Docker: https://docs.docker.com
- Adminer: https://www.adminer.org/
- WordPress: https://developer.wordpress.org/
- Nginx: https://nginx.org/en/docs/
- [Docker vs VM: What's the Difference, and Why You Care!](https://www.youtube.com/watch?v=D82C7JS_2iw)
- [Containers From Scratch • Liz Rice • GOTO 2018](https://www.youtube.com/watch?v=8fi7uSYlOdc)
- [Documentation/cgroup-v1/cpusets.txt](https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt)

## AI Usage

- Debugging and investigating problems
- Used as a Search engine
- Reviewing and find edge cases in the implementation that needs to be fixed
