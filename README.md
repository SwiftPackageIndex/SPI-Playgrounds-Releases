# Release process

- Tag
- Archive
- In Organizer: "Distribute App" -> "Developer ID" -> "Upload" -> "Automatically manage signing" -> "Upload"
- After notarized → "Export Notarized App" and place it _at the top level_ of this repository
- Update `release-notes.html`
- Run `make release VERSION=x.y.z` which
  - compresses the app bundle and copies it to `./releases` (leaving `SPI-Playgrounds.app.zip` at the top level to provide a stable download link)
  - copies `release-notes.html` to the proper versioned file
  - updates the appcast
  - commits the changes
- Push to release

The download link for the latest release is

https://github.com/SwiftPackageIndex/SPI-Playgrounds-Releases/raw/main/SPI-Playgrounds.app.zip
