all: propgeo-server propgeo-cli propgeo-benchmark propgeo-luamemtest

.PHONY: propgeo-server
propgeo-server:
	@./scripts/build.sh propgeo-server

.PHONY: propgeo-cli
propgeo-cli:
	@./scripts/build.sh propgeo-cli

.PHONY: propgeo-benchmark
propgeo-benchmark:
	@./scripts/build.sh propgeo-benchmark

.PHONY: propgeo-luamemtest
propgeo-luamemtest:
	@./scripts/build.sh propgeo-luamemtest

test:
	@./scripts/test.sh

package:
	@rm -rf packages/
	@scripts/package.sh Windows windows amd64
	@scripts/package.sh Mac     darwin  amd64
	@scripts/package.sh Linux   linux   amd64
	@scripts/package.sh FreeBSD freebsd amd64
	@scripts/package.sh ARM     linux   arm
	@scripts/package.sh ARM64   linux   arm64

clean:
	rm -rf propgeo-server propgeo-cli propgeo-benchmark propgeo-luamemtest 

distclean: clean
	rm -rf packages/

install: all
	cp propgeo-server /usr/local/bin
	cp propgeo-cli /usr/local/bin
	cp propgeo-benchmark /usr/local/bin

uninstall: 
	rm -f /usr/local/bin/propgeo-server
	rm -f /usr/local/bin/propgeo-cli
	rm -f /usr/local/bin/propgeo-benchmark

