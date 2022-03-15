FROM golang:1.17-alpine
ARG VERSION=v0.0.2
ARG ARCH=amd64
ARG OS=linux

RUN apk add curl && \
  curl -L -o /go/bin/ee-hello-kube https://github.com/damacus/ee-hello-kube/releases/download/${VERSION}/ee-hello-kube-${VERSION}-${OS}-${ARCH}.tar.gz && \
  chmod +x /go/bin/ee-hello-kube && \
  apk del curl
RUN test -x /go/bin/ee-hello-kube
ENTRYPOINT [ "/go/bin/ee-hello-kube" ]
EXPOSE 8080
