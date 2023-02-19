import ProjectDescription

let project = Project(
    name: "Seedling",
    organizationName: "Team Seedling",
    targets: [
        .init(name: "Seedling",
              platform: .iOS,
              product: .app,
              bundleId: "joshgrant.me.seedling",
              deploymentTarget: .iOS(targetVersion: "14.0", devices: [.ipad, .iphone]),
              infoPlist: .default,
              sources: ["Sources/**"],
              resources: ["Resources/**"],
              coreDataModels: [.init(.relativeToCurrentFile("Sources/Database/Seedling.xcdatamodeld"))]),
        .init(name: "SeedlingTests",
              platform: .iOS,
              product: .unitTests,
              bundleId: "joshgrant.me.seedlingTests",
              deploymentTarget: .iOS(targetVersion: "14.0", devices: [.ipad, .iphone]),
              infoPlist: .default,
              sources: ["Tests/**"],
              dependencies: [.target(name: "Seedling")]),
        .init(name: "SeedlingUITests",
              platform: .iOS,
              product: .uiTests,
              bundleId: "joshgrant.me.seedlingUITests",
              deploymentTarget: .iOS(targetVersion: "14.0", devices: [.ipad, .iphone]),
              infoPlist: .default,
              sources: ["UITests/**"],
              dependencies: [.target(name: "Seedling")])
    ])
