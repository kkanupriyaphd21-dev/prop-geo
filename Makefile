all: 
	@./build.sh
clean:
	rm -f propgeo-server
	rm -f propgeo-cli
	rm -f propgeo-benchmark
	rm -f propgeo-luamemtest
test:
	@./build.sh test
cover:
	@./build.sh cover
install: all
	cp propgeo-server /usr/local/bin
	cp propgeo-cli /usr/local/bin
	cp propgeo-benchmark /usr/local/bin
uninstall: 
	rm -f /usr/local/bin/propgeo-server
	rm -f /usr/local/bin/propgeo-cli
	rm -f /usr/local/bin/propgeo-benchmark
package:
package:
	@./build.sh package
