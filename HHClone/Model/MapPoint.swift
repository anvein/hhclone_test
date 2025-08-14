struct MapPoint: Hashable {
    var latitude: Double
    var longitude: Double
}

extension MapPoint {
    static let testPoint: Self = .init(latitude: 57.139684, longitude: 65.593876)
}
