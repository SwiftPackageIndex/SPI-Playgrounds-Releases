APP_BUNDLE = SPI-Playgrounds.app

ifndef VERSION
$(error VERSION is not set)
endif

zip:
	@ditto -c -k --sequesterRsrc --keepParent $(APP_BUNDLE) $(APP_BUNDLE).zip
	@cp $(APP_BUNDLE).zip releases/SPI-Playgrounds-$(VERSION).app.zip
	@rm -rf $(APP_BUNDLE)
	@diff $(APP_BUNDLE).zip releases/SPI-Playgrounds-$(VERSION).app.zip

release-notes:
	@docker run --rm -it -v "$(PWD)":/host -w /host pandoc/alpine release-notes.md -s --self-contained -f markdown -t html5 -c release-notes.css -o release-notes.html
	@#cp release-notes.html releases/SPI-Playgrounds-$(VERSION).app.html

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
