public extension Any? {
    subscript(key key: String) -> Any? {
        guard let dictionary = self as? [String: Any] else { return nil }
        return dictionary[key]
    }
}
