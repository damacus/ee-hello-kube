# ee-hello-kube

A Hello World app written in GoLang deployed to Kubernetes.

## GoLang

The Golang app uses builtin net/http to server requests.
It should respond with Hello World on port 8080 if you compile and run the app directly.

### Building & Running

```shell
go build
chmod +x ee-hello-kube
./ee-hello-world
curl localhost:8080
```

## Dockerfile

Using Alpine, we curl the pre-built binary stored on GitHub, then expose port 8080.

The Dockerfile takes a few ARGs, the most important being VERSION. This controls the version of the app being downloaded and run.

Docker containers are currently built for arm64 and amd64.

## docker-compose file

The docker-compose file is there for quick local testing to see if the app works when run in a container, before we worry about Kubernetes health checks.

## Helm Chart

Using a basic helm chart we use a delpoyment to serve up the Docker container.

This is not currently passing health checks when run on my local k3s cluster.

## CI System

There are two workflows, build and publish.

### Build

The build workflow simply runs go test and go build to see if the app builds.
Ideally we would also build the Docker container and test it with the InSpec tests written in the test folder.

### Publish

The Go program is built for the following platforms:

- amd64-linux
- amd64-darwin
- arm64-linux
- arm64-darwin

The Docker container is built for arm64 and amd64 using buildx. and pushed to GitHub container registry.

There is currently no publish step for the helm chart.
