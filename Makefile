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
	@docker run --rm -it -v "$(PWD)":/host -w /host pandoc/alpine release-notes.md -s --self-contained -f markdown -t html5 -c release-notes.css \
		-o releases/SPI-Playgrounds-$(VERSION).app.html

appcast: release-notes
	@# -f parameter doesn't work (SecItemImport error -25257)
	@# use workaround via -s
	@./sparkle/generate_appcast \
		-s $(shell cat ./key/spi-playgrounds-sparkle-pkey.ed25519) \
			--release-notes-url-prefix "https://spi-playgrounds-updates.swiftpackageindex.com/releases/" \
		--download-url-prefix "https://spi-playgrounds-updates.swiftpackageindex.com/releases/" \
		./releases/

commit:
	git add --all
	git commit -m "Release $(VERSION)"

release: zip appcast commit
