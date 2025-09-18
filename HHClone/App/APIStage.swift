import Foundation

public enum APIStage: String, CaseIterable {
    case development
    case production

    private var plist: [String: Any] {
        PlistDocument(bundle: .main).data["ApiStage"] as! [String: Any]
    }

    private static let defaultsKey: String = "ApiStage"
    static var current: Self = Self.getFromDefaults() ?? .production {
        didSet {
            Self.saveToDefaults(current)
            Self.postNotifyApiStageChanged(current)
        }
    }

    private var currentStageParams: [String: Any] {
        plist[Self.current.rawValue] as! [String: Any]
    }

    public var apiHost: String {
        currentStageParams["api"][key: "host"] as! String
    }

    public var apiProtocol: String {
        currentStageParams["api"][key: "protocol"] as! String
    }

    public var apiBaseUrl: URL {
        let urlString = "\(self.apiProtocol)://\(self.apiHost)"
        guard let url = URL(string: urlString) else {
            fatalError("Error creating URL from \(urlString) for api stage \(self.rawValue)")
        }
        return url
    }

    public func setAsCurrent() {
        Self.current = self
    }

    // TODO: сделать обертку для UserDefaults
    private static func getFromDefaults() -> APIStage? {
        guard let rawValue = UserDefaults.standard.string(forKey: Self.defaultsKey) else {
            return nil
        }
        return .init(rawValue: rawValue)
    }

    private static func saveToDefaults(_ value: Self) {
        UserDefaults.standard.set(value.rawValue, forKey: Self.defaultsKey)
    }

    private static func postNotifyApiStageChanged(_ newStage: Self) {
        NotificationCenter.default.post(
            name: Notification.apiStageChanged,
            object: nil,
            userInfo: [Notification.apiStageKey: newStage]
        )
    }

}

// MARK: - Notification

extension Notification {
    fileprivate static let apiStageKey: String = "apiStage"

    static let apiStageChanged: Notification.Name = .init("apiStageChanged")

    func getApiStage() -> APIStage? {
        self.userInfo?[Self.apiStageKey] as? APIStage
    }
}
