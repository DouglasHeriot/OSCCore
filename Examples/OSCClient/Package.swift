import PackageDescription

let package = Package(
    name: "OSCClient",
    dependencies: [
        .Package(url: "https://github.com/VeniceX/UDP.git", majorVersion: 0, minor: 12),
        .Package(url: "../..", majorVersion: 0)
    ]
)
