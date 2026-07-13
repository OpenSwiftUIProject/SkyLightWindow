import ProjectDescription

public enum MoveToSkyVariant {
    case swiftUI
    case openSwiftUI

    var name: String {
        switch self {
        case .swiftUI: "MoveToSky"
        case .openSwiftUI: "MoveToSkyOpenSwiftUI"
        }
    }

    var bundleId: String {
        switch self {
        case .swiftUI: "wiki.qaq.MoveToSky"
        case .openSwiftUI: "wiki.qaq.MoveToSky.OpenSwiftUI"
        }
    }

    var developmentTeam: String {
        "VB7MJ8R223"
    }

    var traits: Set<Package.Dependency.Trait> {
        switch self {
        case .swiftUI: [.defaults]
        case .openSwiftUI: [.defaults, "OpenSwiftUI"]
        }
    }

    var usesOpenSwiftUI: Bool {
        switch self {
        case .swiftUI: false
        case .openSwiftUI: true
        }
    }
}

extension Project {
    public static func moveToSky(_ variant: MoveToSkyVariant) -> Project {
        let skyLightWindow = Package.Dependency.package(
            path: "../../../",
            traits: variant.traits
        )
        let lookInside = Package.Dependency.package(
            url: "https://github.com/LookInsideApp/LookInside-Release.git",
            from: "0.2.2"
        )
        var baseSettings: SettingsDictionary = [
            "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
            "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
            "CODE_SIGN_STYLE": "Automatic",
            "CURRENT_PROJECT_VERSION": "1",
            "DEVELOPMENT_TEAM": .string(variant.developmentTeam),
            "ENABLE_HARDENED_RUNTIME": "YES",
            "ENABLE_PREVIEWS": "YES",
            "MARKETING_VERSION": "1.0",
            "REGISTER_APP_GROUPS": "YES",
            "SWIFT_EMIT_LOC_STRINGS": "YES",
            "SWIFT_VERSION": "5.0",
        ]

        if variant.usesOpenSwiftUI {
            baseSettings["SWIFT_ACTIVE_COMPILATION_CONDITIONS"] = ["$(inherited)", "OpenSwiftUI"]
        }

        return Project(
            name: variant.name,
            packages: [
                skyLightWindow,
                lookInside,
            ],
            targets: [
                .target(
                    name: variant.name,
                    destinations: .macOS,
                    product: .app,
                    bundleId: variant.bundleId,
                    deploymentTargets: .macOS("15.0"),
                    infoPlist: .default,
                    buildableFolders: ["../../MoveToSky"],
                    entitlements: "../../MoveToSky/MoveToSky.entitlements",
                    dependencies: [
                        .package(product: "SkyLightWindow"),
                        .package(product: "LookInsideServer"),
                    ],
                    settings: .settings(
                        base: baseSettings,
                        release: [
                            "EXCLUDED_SOURCE_FILE_NAMES": ["$(inherited)", "LookInsideServer*"],
                        ]
                    )
                ),
            ]
        )
    }
}
