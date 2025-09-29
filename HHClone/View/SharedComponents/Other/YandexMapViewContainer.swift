//import SwiftUI
//import YandexMapsMobile
//
//struct YandexMapViewContainer: View {
//    var coordinate: YMKPoint
//    var isGestureEnabled: Bool = true
//    var zoom: Float = 15
//    var style:
//
//    var body: some View {
//        #if DEBUG
//        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
//            let _ = print("1")
//            Color.gray
//        } else {
//            let _ = print("2")
//            YandexMapView(coordinate: coordinate, isGestureEnabled: isGestureEnabled, zoom: zoom)
//        }
//        #else
//        YandexMapView(coordinate: coordinate, isGestureEnabled: isGestureEnabled, zoom: zoom)
//        #endif
//    }
//}
