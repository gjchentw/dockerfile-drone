FROM gjchen/alpine:3.8
MAINTAINER gjchen <gjchen.tw@gmail.com>

ENV	GOPATH="/tmp/go"

RUN	apk --no-cache --no-progress upgrade -f && \
	apk --no-cache --no-progress add ca-certificates git bash sqlite && \
	apk --no-cache --no-progress add --virtual build-deps sqlite-dev make go g++ musl-dev && \
	mkdir -p /tmp/go && ln -s /usr/local/bin /tmp/go/bin && \
	go get -ldflags '-extldflags "-static" -X github.com/drone/drone/version.VersionDev='$(date +%Y%m%d) github.com/drone/drone/cmd/drone-agent && \
	rm -rf /tmp/go && \
	apk --no-progress del build-deps
	

ENTRYPOINT	["/usr/local/bin/drone-agent"]
