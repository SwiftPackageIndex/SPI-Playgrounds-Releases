appcast:
	@# -f parameter doesn't work (SecItemImport error -25257)
	@# use workaround via -s
	@./sparkle/generate_appcast \
		-s $(shell cat ./key/spi-playgrounds-sparkle-pkey.ed25519) \
		--download-url-prefix "https://github.com/SwiftPackageIndex/SPI-Playgrounds-Releases/raw/main/releases/" ./releases/
