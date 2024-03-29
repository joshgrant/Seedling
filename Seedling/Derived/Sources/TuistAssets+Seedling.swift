// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum SeedlingAsset {
  public static let blueBubble = SeedlingImages(name: "blueBubble")
  public static let clearBubble = SeedlingImages(name: "clearBubble")
  public static let orangeBubble = SeedlingImages(name: "orangeBubble")
  public static let background = SeedlingColors(name: "background")
  public static let darkGrey = SeedlingColors(name: "dark_grey")
  public static let darkText = SeedlingColors(name: "dark_text")
  public static let emerald = SeedlingColors(name: "emerald")
  public static let orange = SeedlingColors(name: "orange")
  public static let sectionHeaderBackground = SeedlingColors(name: "section_header_background")
  public static let separator = SeedlingColors(name: "separator")
  public static let text = SeedlingColors(name: "text")
  public static let extrasSelected = SeedlingImages(name: "extras_selected")
  public static let extrasUnselected = SeedlingImages(name: "extras_unselected")
  public static let scheduleSelected = SeedlingImages(name: "schedule_selected")
  public static let scheduleUnselected = SeedlingImages(name: "schedule_unselected")
  public static let settingsSelected = SeedlingImages(name: "settings_selected")
  public static let settingsUnselected = SeedlingImages(name: "settings_unselected")
  public static let toDoSelected = SeedlingImages(name: "to_do_selected")
  public static let toDoUnselected = SeedlingImages(name: "to_do_unselected")
  public static let bar = SeedlingImages(name: "bar")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class SeedlingColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension SeedlingColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: SeedlingColors) {
    let bundle = SeedlingResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: SeedlingColors) {
    let bundle = SeedlingResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct SeedlingImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = SeedlingResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension SeedlingImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the SeedlingImages.image property")
  convenience init?(asset: SeedlingImages) {
    #if os(iOS) || os(tvOS)
    let bundle = SeedlingResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: SeedlingImages) {
    let bundle = SeedlingResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: SeedlingImages, label: Text) {
    let bundle = SeedlingResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: SeedlingImages) {
    let bundle = SeedlingResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
