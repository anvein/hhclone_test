import SwiftUI

struct GetContentSizeModifier: ViewModifier {
    @Binding var width: CGFloat
    @Binding var height: CGFloat

    var updateOnChange: Bool
    var updateOnAppear: Bool

    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geo in
                    Color.clear
                        .onChange(of: geo.size) { newSize in
                            if updateOnChange {
                                width = newSize.width
                                height = newSize.height
                            }
                        }
                        .onAppear {
                            if updateOnAppear {
                                width = geo.size.width
                                height = geo.size.height
                            }
                        }
                }
            }
    }
}

extension View {
    func getContentSize(
        width: Binding<CGFloat>? = nil,
        height: Binding<CGFloat>? = nil,
        updateOnChange: Bool = true,
        updateOnAppear: Bool = true
    ) -> some View {
        self.modifier(
            GetContentSizeModifier(
                width: width ?? .constant(0),
                height: height ?? .constant(0),
                updateOnChange: updateOnChange,
                updateOnAppear: updateOnAppear
            )
        )
    }
}
