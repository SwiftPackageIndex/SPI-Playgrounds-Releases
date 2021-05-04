APP_NAME = "SPI Playgrounds.app"
APP_ZIP = SPI-Playgrounds.app.zip

ifndef VERSION
$(error VERSION is not set)
endif

zip:
	@ditto -c -k --sequesterRsrc --keepParent $(APP_NAME) $(APP_ZIP)
	@cp $(APP_ZIP) releases/SPI-Playgrounds-$(VERSION).app.zip
	@rm -rf $(APP_NAME)
	@diff $(APP_ZIP) releases/SPI-Playgrounds-$(VERSION).app.zip

release-notes:
	@cp release-notes.html releases/SPI-Playgrounds-$(VERSION).app.html

appcast:
	@# -f parameter doesn't work (SecItemImport error -25257)
	@# use workaround via -s
	@./sparkle/generate_appcast \
		-s $(shell cat ./key/spi-playgrounds-sparkle-pkey.ed25519) \
		--download-url-prefix "https://github.com/SwiftPackageIndex/SPI-Playgrounds-Releases/raw/main/releases/" \
		./releases/

commit:
	git add --all
	git commit -m "Release $(VERSION)"

release: zip release-notes appcast commit
