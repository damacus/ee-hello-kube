FROM golang:1.17-alpine
ARG VERSION=v0.0.1
ARG ARCH=

RUN apk add curl && \
  curl -o /go/bin/ee-hello-kube https://github.com/damacus/ee-hello-kube/releases/download/${VERSION}/ee-hello-kube-$VERSION-linux-${ARCH}.tar.gz && \
  chmod +x /go/bin/ee-hello-kube && \
  apk del curl
RUN test -x /go/bin/ee-hello-kube
ENTRYPOINT [ "/go/bin/ee-hello-kube" ]
EXPOSE 8080
