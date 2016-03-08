all: 
	@./build.sh
clean:
	rm -f propgeo-server
	rm -f propgeo-cli
test:
	@./build.sh test
install: all
	cp propgeo-server /usr/local/bin
	cp propgeo-cli /usr/local/bin
uninstall: 
	rm -f /usr/local/bin/propgeo-server
	rm -f /usr/local/bin/propgeo-cli
