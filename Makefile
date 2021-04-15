APP_BUNDLE = SPI-Playgrounds.app

zip:
ifndef VERSION
$(error VERSION is not set)
endif
	@ditto -c -k --sequesterRsrc --keepParent $(APP_BUNDLE) $(APP_BUNDLE).zip
	@cp $(APP_BUNDLE).zip releases/SPI-Playgrounds-$(VERSION).app.zip
	@rm -rf $(APP_BUNDLE)
	@diff $(APP_BUNDLE).zip releases/SPI-Playgrounds-$(VERSION).app.zip

appcast:
	@# -f parameter doesn't work (SecItemImport error -25257)
	@# use workaround via -s
	@./sparkle/generate_appcast \
		-s $(shell cat ./key/spi-playgrounds-sparkle-pkey.ed25519) \
		--download-url-prefix "https://github.com/SwiftPackageIndex/SPI-Playgrounds-Releases/raw/main/releases/" ./releases/

commit:
ifndef VERSION
$(error VERSION is not set)
endif
	git add --all
	git commit -m "Release $(VERSION)"

release: zip appcast commit
