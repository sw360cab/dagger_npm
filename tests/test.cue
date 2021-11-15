package test

import (
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/alpine"
	"alpha.dagger.io/os"
	"github.com/sw360cab/dagger_npm"
)

TestData: dagger.#Artifact

TestNpm: {
	pkg: dagger_npm.#Package & {
		source: TestData
	}

	test: os.#Container & {
		image: alpine.#Image & {
			package: bash: "=5.1.0-r0"
		}
		mount: "/node_modules": from: pkg.build
		command: """
			[ -d /node_modules ] && [ ! -z "$(ls -A /node_modules)" ] # test not empty folder
			"""
	}
}
