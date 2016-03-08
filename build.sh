#!/bin/bash
set -e

VERSION="0.0.1"
BUILD_TIME=$(date +%FT%T%z)
GIT_SHA=$(git rev-parse --short HEAD)
LDFLAGS="-X github.com/tidwall/propgeo/core.Version=${VERSION} -X github.com/tidwall/propgeo/core.BuildTime=${BUILD_TIME} -X github.com/tidwall/propgeo/core.GitSHA=${GIT_SHA}"

export GO15VENDOREXPERIMENT=1

cd $(dirname "${BASH_SOURCE[0]}")
OD="$(pwd)"

# temp directory for storing isolated environment.
TMP="$(mktemp -d -t propgeo.XXXX)"
function rmtemp {
  	rm -rf "$TMP"
}
trap rmtemp EXIT

if [ "$NOCOPY" != "1" ]; then
	# copy all files to an isloated directory.
	WD="$TMP/src/github.com/tidwall/propgeo"
	GOPATH="$TMP"
	for file in `find . -type f`; do
		# TODO: use .gitignore to ignore, or possibly just use git to determine the file list.
		if [[ "$file" != "." && "$file" != ./.git* && "$file" != ./data* && "$file" != ./propgeo-* ]]; then
			mkdir -p "$WD/$(dirname "${file}")"
			cp -P "$file" "$WD/$(dirname "${file}")"
		fi
	done
	cd $WD
fi

core/gen.sh

# build and store objects into original directory.
go build -ldflags "$LDFLAGS" -o "$OD/propgeo-server" cmd/propgeo-server/*.go
go build -ldflags "$LDFLAGS" -o "$OD/propgeo-cli" cmd/propgeo-cli/*.go

# test if requested
if [ "$1" == "test" ]; then
	$OD/propgeo-server -p 9876 -d "$TMP" -q &
	PID=$!
	function testend {
	  	kill $PID &
	}
	trap testend EXIT
	go test $(go list ./... | grep -v /vendor/)
fi

