# Release process

- Tag
- Archive
- In Organizer: "Distribute App" -> "Developer ID" -> "Upload" -> "Automatically manage signing"
- After notarized → "Export Notarized App"
- Finder → compress → rename `SPI-Playgrounds-x.y.x.zip`
- Move into releases folder in this repository
- Run `make appcast`
- Commit changes
- Push to release
