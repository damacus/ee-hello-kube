FROM alpine
ARG VERSION=v0.0.4
ARG ARCH=
ARG OS=linux

RUN apk add curl &&\
  curl -L -o /tmp/ee-hello-kube.tar.gz https://github.com/damacus/ee-hello-kube/releases/download/${VERSION}/ee-hello-kube-${VERSION}-${OS}-${ARCH}.tar.gz &&\
  tar -xzf /tmp/ee-hello-kube.tar.gz -C /usr/local/bin &&\
  chmod +x /usr/local/bin/ee-hello-kube &&\
  apk del curl &&\
  rm /tmp/ee-hello-kube.tar.gz && \
  mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
RUN test -x /usr/local/bin/ee-hello-kube

ENTRYPOINT [ "/usr/local/bin/ee-hello-kube" ]
EXPOSE 8080
