# gjchen/drone@Dockerhub
# gjchen/drone-agent@Dockerhub
Alpine Linux with Drone CI/CD Server/Agent
* Base docker image: https://hub.docker.com/r/gjchen/alpine/

drone-server
============

```
docker run -d --name drone-server \
	-e DRONE_*=CUSTOM_DRONE_SETTINGS \
	-p 80:80 -p 443:443 -p 9000:9000 \
	gjchen/drone
```

Run as a another UID for 1000:

```
-e SUEXEC="user"
-e SUEXEC="uid:gid"
```

Default location for a default sqlite3 database:

```
	DRONE_DATABASE_DATASOURCE="/var/lib/drone/drone.sqlite" \
	DRONE_DATABASE_DRIVER="sqlite3"
```

drone-agent
===========

```
docker run -it gjchen/drone-agent help
```
