// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Common {
    /// Продолжить
    internal static let `continue` = L10n.tr("Localizable", "common_continue", fallback: "Продолжить")
  }
  internal enum LoginScreen {
    /// Электронная почта или телефон
    internal static let emailOrPhone = L10n.tr("Localizable", "loginScreen_emailOrPhone", fallback: "Электронная почта или телефон")
    /// Войти с паролем
    internal static let loginWithPassword = L10n.tr("Localizable", "loginScreen_loginWithPassword", fallback: "Войти с паролем")
    /// Поиск работы
    internal static let searchWork = L10n.tr("Localizable", "loginScreen_searchWork", fallback: "Поиск работы")
    /// Вход в личный кабинет
    internal static let title = L10n.tr("Localizable", "loginScreen_title", fallback: "Вход в личный кабинет")
    internal enum SearchEmployees {
      /// Я ищу сотрудников
      internal static let buttonText = L10n.tr("Localizable", "loginScreen_searchEmployees_buttonText", fallback: "Я ищу сотрудников")
      /// Размещение вакансий и доступ к базе резюме
      internal static let descr = L10n.tr("Localizable", "loginScreen_searchEmployees_descr", fallback: "Размещение вакансий и доступ к базе резюме")
      /// Поиск сотрудников
      internal static let title = L10n.tr("Localizable", "loginScreen_searchEmployees_title", fallback: "Поиск сотрудников")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
