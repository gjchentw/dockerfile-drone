FROM gjchen/alpine:3.7
MAINTAINER gjchen <gjchen.tw@gmail.com>

ENV	GOPATH="/tmp/go" \
	SUEXEC="root" \
	DRONE_DEBUG="" \
	DRONE_HOST="http://localhost" \
	DRONE_SERVER_ADDR=":80" \
	DRONE_GITHUB=0 \
	DRONE_DATABASE_DATASOURCE="/var/lib/drone/drone.sqlite" \
	DRONE_DATABASE_DRIVER="sqlite3"

RUN	apk --no-cache --no-progress upgrade -f && \
	apk --no-cache --no-progress add ca-certificates git bash sqlite && \
	apk --no-cache --no-progress add --virtual build-deps sqlite-dev make go g++ musl-dev && \
	mkdir -p /tmp/go && ln -s /usr/local/bin /tmp/go/bin && \
	go get -ldflags '-extldflags "-static" -X github.com/drone/drone/version.VersionDev='$(date +%Y%m%d) github.com/drone/drone/cmd/drone-server && \
	go get -ldflags '-extldflags "-static" -X github.com/drone/drone/version.VersionDev='$(date +%Y%m%d) github.com/drone/drone/cmd/drone-agent && \
	rm -rf /tmp/go/ && \
	apk --no-progress del build-deps
	
ADD	s6.d /etc/s6.d

VOLUME	["/var/lib/drone"]
EXPOSE	80 443 9000
