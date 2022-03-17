# ee-hello-kube

A Hello World app written in GoLang deployed to Kubernetes.

## Quick start

- Clone this repository
- `helm install hello-world hello-world -ndefault`
  _note you shouldn't deploy to the default namespace in production_
- The helm chart will now inform you of the DNS address to view to see Hello World

This will pull the needed containers and use the Traefik ingress controller to load balance the container.
You will likely need to amend the `ingress.hosts` value for Minikube:

```yaml
ingress:
  enabled: true
  className: ""
  annotations:
    kubernetes.io/ingress.class: "nginx"
  hosts:
      - host: "hello.<cluster-ip-here>.nip.io"
        paths:
          - path: /
            pathType: Prefix
```

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

Using a basic helm chart we use a delpoyment to serve up the Docker container, fronted my the traefik Ingress controller.

This solution has been tested on K3s with a Traefik ingress controller rather than Minikube to reduce the ammount of time to complete this tech test.

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
