import SwiftUI
import YandexMapsMobile

struct YandexMapView: UIViewRepresentable {
    var coordinate: YMKPoint
    var isGestureEnabled: Bool = true
    var zoom: Float = 15

    func makeUIView(context: Context) -> YMKMapView {
        let mapView = YMKMapView() // YMKMapView(frame: .zero, vulkanPreferred: true) ?? YMKMapView()

        let map = mapView.mapWindow.map
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: coordinate, zoom: zoom, azimuth: 0, tilt: 0)
        )
        map.isTiltGesturesEnabled = isGestureEnabled
        map.isZoomGesturesEnabled = isGestureEnabled
        map.isRotateGesturesEnabled = isGestureEnabled
        map.isScrollGesturesEnabled = isGestureEnabled

        map.isNightModeEnabled = true
        map.setMapStyleWithStyle("[]")

        addPlacemark(to: mapView, coordinate: coordinate)

        return mapView
    }

    // Обновление карты при изменении данных
    func updateUIView(_ uiView: YMKMapView, context: Context) {
        uiView.mapWindow.map.move(
            with: .init(target: coordinate, zoom: zoom, azimuth: 0, tilt: 0)
        )
        addPlacemark(to: uiView, coordinate: coordinate, withClear: true)
    }

    private func addPlacemark(to view: YMKMapView, coordinate: YMKPoint, withClear: Bool = false) {
        let map = view.mapWindow.map
        if withClear {
            map.mapObjects.clear()
        }

        let placemark = map.mapObjects.addPlacemark()
        placemark.geometry = coordinate
        placemark.setIconWith(AppImage.Icons.mapWorkPin.image)
    }

}
