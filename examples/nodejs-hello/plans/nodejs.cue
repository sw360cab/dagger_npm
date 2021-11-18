package nodejs

import (
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/os"
	"alpha.dagger.io/docker"
	"github.com/sw360cab/dagger_npm"
)

repository: dagger.#Artifact & dagger.#Input

// Build the source code using Yarn
app: dagger_npm.#Package & {
	source: repository
}

// package the static HTML from yarn into a Docker image
image: os.#Container & {
	image: docker.#Build & {
		source: repository
	}

	// app.build references our app key above
	// which infers a dependency that Dagger
	// uses to generate the DAG
	//copy: "/usr/src/app": from: app.source
	copy: "/usr/src/app/node_modules": from: app.build
	//command: "cd /usr/src/app && npm run start"
}

// push the image to a registry
push: docker.#Push & {
	// leave target blank here so that different
	// environments can push to different registries
	target: string

	// the source of our push resource
	// is the image resource we declared above
	source: image
}