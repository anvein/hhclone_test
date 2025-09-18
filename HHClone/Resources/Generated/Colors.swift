// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

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

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum AssetColors {
  internal enum Colors {
    internal static let accentColor = ColorAsset(name: "AccentColor")
    internal enum Button {
      internal static let blue = ColorAsset(name: "Button/blue")
      internal static let disableGrey = ColorAsset(name: "Button/disableGrey")
      internal static let green = ColorAsset(name: "Button/green")
      internal static let grey = ColorAsset(name: "Button/grey")
    }
    internal enum Icons {
      internal static let bgBlue = ColorAsset(name: "Icons/bgBlue")
      internal static let bgGreen = ColorAsset(name: "Icons/bgGreen")
      internal static let iconBlue = ColorAsset(name: "Icons/iconBlue")
      internal static let iconGreen = ColorAsset(name: "Icons/iconGreen")
    }
    internal enum Shimmer {
      internal static let textGreen1 = ColorAsset(name: "Shimmer/textGreen1")
      internal static let textGrey1 = ColorAsset(name: "Shimmer/textGrey1")
      internal static let textWhite1 = ColorAsset(name: "Shimmer/textWhite1")
    }
    internal enum TabBar {
      internal static let separator = ColorAsset(name: "TabBar/separator")
    }
    internal enum Text {
      internal static let accentBlue = ColorAsset(name: "Text/accentBlue")
      internal static let green = ColorAsset(name: "Text/green")
      internal static let main = ColorAsset(name: "Text/main")
      internal static let mainReversed = ColorAsset(name: "Text/mainReversed")
      internal static let redError = ColorAsset(name: "Text/redError")
      internal static let second = ColorAsset(name: "Text/second")
    }
    internal enum TextField {
      internal static let bgDarkGrey = ColorAsset(name: "TextField/bgDarkGrey")
    }
    internal static let bgMain = ColorAsset(name: "bgMain")
    internal static let bgSecondary = ColorAsset(name: "bgSecondary")
    internal static let blueAccent = ColorAsset(name: "blueAccent")
    internal static let grey1 = ColorAsset(name: "grey1")
    internal static let grey2 = ColorAsset(name: "grey2")
    internal static let grey3 = ColorAsset(name: "grey3")
    internal static let grey4 = ColorAsset(name: "grey4")
    internal static let grey5 = ColorAsset(name: "grey5")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
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
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
