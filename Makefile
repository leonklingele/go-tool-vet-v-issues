PWD := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GOPKG = github.com/leonklingele/go-tool-vet-v-issues
GOPATH = "$(CURDIR)/vendor:$(CURDIR)"

FOLDERS = $(shell find . -mindepth 1 -type d -not -path "*.git*" -not -path "./vendor*" -not -path "*bin*")

all: build

goget:
	GOPATH=$(GOPATH) go get github.com/rogpeppe/godeps
	GOPATH=$(GOPATH) $(CURDIR)/vendor/bin/godeps -u dependencies.tsv
	mkdir -p $(shell dirname "$(CURDIR)/vendor/src/$(GOPKG)")
	rm -f $(CURDIR)/vendor/src/$(GOPKG)
	ln -sf $(PWD) $(CURDIR)/vendor/src/$(GOPKG)

build: goget
	GOPATH=$(GOPATH) go build $(LDFLAGS) -o bin/hello .

govet:
	GOPATH=$(GOPATH) go tool vet -v $(FOLDERS)

clean:
	rm -rf vendor/
	rm -rf bin/

.PHONY: all goget build govet clean
