#!/bin/bash
set -e

VERSION="0.0.1"
BUILD_TIME=$(date +%FT%T%z)
GIT_SHA=$(git rev-parse --short HEAD)
LDFLAGS="-X github.com/tidwall/propgeo/core.Version=${VERSION} -X github.com/tidwall/propgeo/core.BuildTime=${BUILD_TIME} -X github.com/tidwall/propgeo/core.GitSHA=${GIT_SHA}"

cd $(dirname "${BASH_SOURCE[0]}")
OD="$(pwd)"

# copy all files to an isloated directory.
TMP="$(mktemp -d -t propgeo)"
function rmtemp {
  	rm -rf "$TMP"
}
trap rmtemp EXIT
WD="$TMP/src/github.com/tidwall/propgeo"
GOPATH="$TMP"

for file in `find . -type f`; do
	if [[ "$file" != "." && "$file" != ./.git* && "$file" != ./data* && "$file" != ./propgeo-* ]]; then
		mkdir -p "$WD/$(dirname "${file}")"
		cp -P "$file" "$WD/$(dirname "${file}")"
	fi
done

# build and store objects into original directory.
cd $WD
go build -ldflags "$LDFLAGS" -o "$OD/propgeo-server" cmd/propgeo-server/*.go
go build -ldflags "$LDFLAGS" -o "$OD/propgeo-cli" cmd/propgeo-cli/*.go



