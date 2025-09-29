struct MapPoint: Hashable {
    var latitude: Double
    var longitude: Double

    static func map(from apiDto: LocationApiDto) -> Self {
        .init(latitude: apiDto.latitude, longitude: apiDto.longitude)
    }
}

extension MapPoint {
    static let testPoint: Self = .init(latitude: 57.139684, longitude: 65.593876)
}
