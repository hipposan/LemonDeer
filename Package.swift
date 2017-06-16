import PackageDescription

let package = Package(
    name: "LemonDeer",
    dependencies: [
        .Package(url: "https://github.com/hipposan/LemonDeer.git", majorVersion: 1.0.0)
    ]
)