import ProjectDescription

let project = Project(
    name: "Seedling",
    organizationName: "Team Seedling",
    targets: [
        .init(name: "Seedling",
              platform: .iOS,
              product: .app,
              bundleId: "joshgrant.me.seedling",
              deploymentTarget: .iOS(targetVersion: "15.0", devices: [.ipad, .iphone]),
              infoPlist: .none,
              sources: ["Sources/**"],
              resources: ["Resources/**"],
              settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])),
        .init(name: "SeedlingTests",
              platform: .iOS,
              product: .unitTests,
              bundleId: "joshgrant.me.seedlingTests",
              deploymentTarget: .iOS(targetVersion: "15.0", devices: [.ipad, .iphone]),
              infoPlist: .none,
              sources: ["Tests/**"],
              settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])),
        .init(name: "SeedlingUITests",
              platform: .iOS,
              product: .uiTests,
              bundleId: "joshgrant.me.seedlingUITests",
              deploymentTarget: .iOS(targetVersion: "15.0", devices: [.ipad, .iphone]),
              infoPlist: .none,
              sources: ["UITests/**"],
              settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"]))
    ])
