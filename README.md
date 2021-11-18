# NPM package for Dagger.io

## Prerequisites

* Dagger [installed](https://docs.dagger.io/1001/install/)

## Running tests

```bash
dagger init 
dagger new staging -p tests
dagger -e staging up
```

## Running example

```bash
cd examples/nodejs-hello # or cd examples/react-hello
dagger init
# create environment
dagger new local -p ./plans/local
# add inputs
dagger -e local input socket dockerSocket /var/run/docker.sock
dagger -e local input dir repository ./ # for React example: dir app.source ./
# run
dagger -e local up
```

## Usage

```bash
cp -r cue.mod/pkg/github.com/sw360cab/dagger_npm $PROJECT_DIR/cue.mod/pkg/github.co/sw360cab/dagger_npm
```
