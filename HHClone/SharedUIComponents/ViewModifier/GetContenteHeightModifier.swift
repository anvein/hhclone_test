import SwiftUI

struct GetContentHeightModifier: ViewModifier {
    @Binding var height: CGFloat

    var updateOnChange = true
    var updateOnAppear = true

    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geoProxy in
                    Color.clear
                        .onChange(of: geoProxy.size.height) { newHeight in
                            if updateOnChange {
                                height = newHeight
                            }
                        }
                        .onAppear {
                            if updateOnAppear {
                                height = geoProxy.size.height
                            }
                        }
                }
            }
    }
}

extension View {
    func getContentHeight(
        height: Binding<CGFloat>,
        updateOnChange: Bool = true,
        updateOnAppear: Bool = true
    ) -> some View {
        self.modifier(
            GetContentHeightModifier(height: height)
        )
    }
}
