FROM gjchen/alpine:3.6
MAINTAINER gjchen <gjchen.tw@gmail.com>

ENV	GOPATH="/tmp/go" \
	PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
	SUEXEC="root" \
	DRONE_DEBUG="" \
	DRONE_HOST="localhost" \
	DRONE_SERVER_ADDR=":80" \
	DRONE_GITHUB=1 \
	DRONE_DATABASE_DATASOURCE="/var/lib/drone/drone.sqlite" \
	DRONE_DATABASE_DRIVER="sqlite3" \
	DRONE_WWW="/tmp/go/src/github.com/drone/drone-ui"

ADD	dist_gen.go /tmp

RUN	apk --no-cache --no-progress upgrade -f && \
	apk --no-cache --no-progress add ca-certificates git bash sqlite && \
	apk --no-cache --no-progress add --virtual build-deps sqlite-dev make go g++ musl-dev nodejs-npm&& \
	mkdir -p /tmp/go && ln -s /usr/local/bin /tmp/go/bin && \
	go get -d github.com/drone/drone-ui/dist && \
	mv /tmp/dist_gen.go ${DRONE_WWW}/dist && \
	cd ${DRONE_WWW} && \
	npm -g install bower && \
	npm -g install polymer-cli && \
	bower --allow-root -f install && \
	go get -ldflags '-extldflags "-static" -X github.com/drone/drone/version.VersionDev='$(date +%Y%m%d) github.com/drone/drone/cmd/drone-server && \
	go get -ldflags '-extldflags "-static" -X github.com/drone/drone/version.VersionDev='$(date +%Y%m%d) github.com/drone/drone/cmd/drone-agent && \
	rm -rf /tmp/go/github.com/drone/ && \
	apk --no-progress del build-deps
	
ADD	s6.d /etc/s6.d

VOLUME	["/var/lib/drone"]
EXPOSE	80 443 9000
