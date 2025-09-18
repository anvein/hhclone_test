import Foundation

struct PlistDocument {
    let data: [String: Any]

    init(bundle: Bundle) {
        guard let data = bundle.infoDictionary else {
            fatalError("Unable to load Info.plist for \(Bundle.main)")
        }
        self.data = data
    }
}
