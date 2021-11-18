package reactapp

import (
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/os"
	"alpha.dagger.io/docker"
	"github.com/sw360cab/dagger_npm"
)

// Build the source code using Yarn
app: dagger_npm.#Package & {
	source: dagger.#Artifact & dagger.#Input
	script: "build"
	buildDir: "build"
}

// package the static HTML from yarn into a Docker image
image: os.#Container & {
	image: docker.#Pull & {
		from: "nginx"
	}
	// app.build references our app key above
	// which infers a dependency that Dagger
	// uses to generate the DAG
	copy: "/usr/share/nginx/html": from: app.build
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