# Release process

- Tag
- Archive
- In Organizer: "Distribute App" -> "Developer ID" -> "Upload" -> "Automatically manage signing" -> "Upload"
- After notarized → "Export Notarized App" and place it _at the top level_ of this repository
- Run `make release VERSION=x.y.z` or step by step
  - Run `make zip VERSION=x.y.z` to compress the app bundle and copy it to `./releases` (leaving `SPI-Playgrounds.app.zip` at the top level to provide a stable download link)
  - Run `make appcast` to update the appcast
  - Run `make commit VERSION=x.y.z` to commit the changes
- Push to release

The download link for the latest release is

https://github.com/SwiftPackageIndex/SPI-Playgrounds-Releases/raw/main/SPI-Playgrounds.app.zip
