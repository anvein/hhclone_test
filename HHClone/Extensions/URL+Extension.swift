import Foundation

extension URL {
    var baseUrlString: String {
        guard let scheme = self.scheme, let host = self.host() else {
            return ""
        }
        let portPart = self.port.map { ":\($0)" } ?? ""

        return "\(scheme)://\(host)\(portPart)"
    }

}
