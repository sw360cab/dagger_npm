package reactapp

import (
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/docker"
)

// docker local socket
dockerSocket: dagger.#Stream & dagger.#Input

// run our nodejs-hello in our local Docker engine
run: docker.#Run & {
	ref: push.ref
	name: "react-hello"
	ports: ["8080:80"]
	socket: dockerSocket
}

// run our local registry
registry: docker.#Run & {
	ref: "registry:2"
	name: "registry-dagger"
	ports: ["5042:5000"]
	socket: dockerSocket
}

// push to our local registry
// this concrete value satisfies the string constraint
// we defined in the previous file
push: target: "localhost:5042/react-hello"

// Application URL
appURL: "http://localhost:8080/" & dagger.#Output