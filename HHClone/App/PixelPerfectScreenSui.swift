import SwiftUI
import UIKit

struct PixelPerfectScreenSui: View {

    private var defaults: DefaultsWrapper

    // MARK: - Params

    var imageName: String
    var scaleFactor: Int
    var initialVAttachSide: ImageVAttachSide
    var initialHAttachSide: ImageHAttachSide

    // MARK: - State

    @State private var isShow: Bool = false // TODO: вынести парамтер в Defaults???
    @State private var opacitySliderValue: Double = 1

    @State private var imageYOffset: Double = 0
    @State private var imageXOffset: Double = 0

    @State private var vAttachSide: ImageVAttachSide = .top
    @State private var hAttachSide: ImageHAttachSide = .trailing

    @State private var beforeImageDraggingOffset: Double?
    @State private var imageDraggingAxis: ImageDragAxis? = nil

    @State private var imageContentMode: ContentMode = .fill
    @State private var isHideToolbars: Bool = false

    // MARK: - Init

    init(
        imageName: String,
        scaleFactor: Int = 3,
        initialVAttachSide: ImageVAttachSide = .top,
        initialHAttachSide: ImageHAttachSide = .leading
    ) {
        self.imageName = imageName
        self.scaleFactor = scaleFactor
        self.initialVAttachSide = initialVAttachSide
        self.initialHAttachSide = initialHAttachSide

        self.defaults = .init(imageName: imageName)
    }

    // MARK: - Body

    var body: some View {
        ZStack(alignment: imageAlignment) {
            if let image = buildImageByName() {
                let scaledImageSize = calcWithScaleFactor(image.size)

                GeometryReader { geometryImage in
                    if let image = buildImageByName() {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: imageContentMode)
                            .frame(alignment: imageAlignment)
                            .opacity(isShow ? opacitySliderValue : 0)
                            .position(calcImagePosition(geometryImage, imageSize: scaledImageSize))
                            .gesture(
                                DragGesture()
                                    .onChanged { drag in
                                        handleOnChangingImageDragGesture(drag)
                                    }
                                    .onEnded { _ in
                                        handleOnEndImageDragGesture()
                                    }
                            )
                    }
                }
                .ignoresSafeArea(edges: .all)
                .onAppear {
                    imageYOffset = defaults.getImageYOffset()
                    imageXOffset = defaults.getImageXOffset()
                    vAttachSide = defaults.getVAttachSide() ?? initialVAttachSide
                    hAttachSide = defaults.getHAttachSide() ?? initialHAttachSide
                    isHideToolbars = defaults.getIsHideToolbars()

                    if let contentMode = defaults.getImageContentMode() {
                        self.imageContentMode = contentMode
                    }
                }
                .frame(width: scaledImageSize.width, alignment: .leading)
            }

            ControlsView(
                isShow: $isShow,
                opacitySliderValue: $opacitySliderValue,
                imageYOffset: $imageYOffset,
                imageXOffset: $imageXOffset,
                vAttachSide: $vAttachSide,
                hAttachSide: $hAttachSide,
                imageContentMode: $imageContentMode,
                isHideToolbars: $isHideToolbars,
                imageName: imageName
            )

            if imageDraggingAxis != nil {
                ImageDraggingInfoView(
                    yOffset: imageYOffset,
                    xOffset: imageXOffset,
                    vAttachSide: vAttachSide,
                    hAttachSide: hAttachSide
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .ppsNavigationBarHidden(isHideToolbars && imageDraggingAxis != nil)
        .ppsTabBarHidden(isHideToolbars && imageDraggingAxis != nil)
    }

    // MARK: - Actions handlers

    private func handleOnChangingImageDragGesture(_ drag: DragGesture.Value) {
        guard opacitySliderValue > 0.1 else { return }

        if imageDraggingAxis == nil {
            imageDraggingAxis = drag.mainDragAxis
            beforeImageDraggingOffset = drag.mainDragAxis == .vertical ? imageYOffset : imageXOffset
        } else {
            if imageDraggingAxis == .vertical {
                imageYOffset = (beforeImageDraggingOffset ?? 0) + ceil(drag.translation.height)
            } else if imageDraggingAxis == .horizontal {
                imageXOffset = (beforeImageDraggingOffset ?? 0) + ceil(drag.translation.width)
            }
        }
    }

    private func handleOnEndImageDragGesture() {
        defaults.save(value: imageYOffset, key: .imageYOffset)
        defaults.save(value: imageXOffset, key: .imageXOffset)

        beforeImageDraggingOffset = nil
        imageDraggingAxis = nil
    }

    // MARK: - Helper functions

    private func buildImageByName() -> UIImage? {
        guard let image = UIImage(named: imageName) else {
            Self.printMessage(prefix: "❌", "не найдено изображение \(imageName)")
            return nil
        }

        return image
    }

    private func calcWithScaleFactor(_ size: CGSize) -> CGSize {
        .init(
            width: size.width / CGFloat(scaleFactor),
            height: size.height / CGFloat(scaleFactor)
        )
    }

    private func calcImagePosition(
        _ geometryImage: GeometryProxy,
        imageSize scaledImageSize: CGSize
    ) -> CGPoint {
        let additionalXOffset = hAttachSide == .leading ? 0 : geometryImage.size.width
        let imageHalfWidth = scaledImageSize.width / 2
        let imageHalfXOffset = hAttachSide == .leading ? imageHalfWidth : -imageHalfWidth

        let additionalYOffset = vAttachSide == .top ? 0 : geometryImage.size.height
        let imageHalfHeight = scaledImageSize.height / 2
        let imageHalfYOffset = vAttachSide == .top ? imageHalfHeight : -imageHalfHeight

        return .init(
            x: imageXOffset + additionalXOffset + imageHalfXOffset,
            y: imageYOffset + additionalYOffset + imageHalfYOffset
        )
    }

    static func printMessage(prefix: String, _ text: String) {
        print("\(prefix) PIXEL PERFECT SCREEN: \(text)")
    }

}


// MARK: - Nested Views

fileprivate struct ControlsView: View {

    private var defaults: DefaultsWrapper

    // MARK: - State

    @Binding private var isShow: Bool
    @Binding private var opacitySliderValue: Double
    @Binding private var imageYOffset: Double
    @Binding private var imageXOffset: Double
    @Binding private var vAttachSide: PixelPerfectScreenSui.ImageVAttachSide
    @Binding private var hAttachSide: PixelPerfectScreenSui.ImageHAttachSide
    @Binding private var imageContentMode: ContentMode
    @Binding private var isHideToolbars: Bool

    @State private var isEditingOpacitySlider: Bool = false

    @State private var isControlsDraggingMode: Bool = false
    @State private var beforeDraggingControlsOffset: Double?
    @State private var controlsOffset: Double = 0

    // MARK: - Init

    init(
        isShow: Binding<Bool>,
        opacitySliderValue: Binding<Double>,
        imageYOffset: Binding<Double>,
        imageXOffset: Binding<Double>,
        vAttachSide: Binding<PixelPerfectScreenSui.ImageVAttachSide>,
        hAttachSide: Binding<PixelPerfectScreenSui.ImageHAttachSide>,
        imageContentMode: Binding<ContentMode>,
        isHideToolbars: Binding<Bool>,
        imageName: String
    ) {
        self._isShow = isShow
        self._opacitySliderValue = opacitySliderValue
        self._imageYOffset = imageYOffset
        self._imageXOffset = imageXOffset
        self._vAttachSide = vAttachSide
        self._hAttachSide = hAttachSide
        self._imageContentMode = imageContentMode
        self._isHideToolbars = isHideToolbars

        self.defaults = .init(imageName: imageName)
    }

    // MARK: - Body

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Toggle(isOn: $isShow) {
                    EmptyView()
                }
                .tint(.blue)
                .fixedSize()

                if isControlsDraggingMode {
                    Image(systemName: "arrow.up.and.line.horizontal.and.arrow.down")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(width: 35, height: 35)
                        .background(.white)
                        .clipShape(.circle)
                        .foregroundStyle(.blue)
                        .opacity(isShow ? 1 : 0)
                        .gesture(
                            DragGesture(coordinateSpace: .global)
                                .onChanged({ drag in
                                    guard let beforeDraggingControlsOffset else {
                                        beforeDraggingControlsOffset = controlsOffset
                                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                        return
                                    }

                                    controlsOffset = beforeDraggingControlsOffset + ceil(drag.translation.height)
                                })
                                .onEnded({ _ in
                                    beforeDraggingControlsOffset = nil
                                    UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                                })
                        )

                    Button {
                        isControlsDraggingMode = false
                        defaults.save(value: controlsOffset, key: .controlsYOffset)
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 19, weight: .semibold))
                            .tint(.green)
                            .frame(width: 35, height: 35)
                            .background(.white)
                            .clipShape(.circle)
                    }
                    .opacity(isShow ? 1 : 0)
                } else {
                    Menu {
                        ForEach(buildMenuItems(), id: \.id) { menuItem in
                            Button(menuItem.title, systemImage: menuItem.systemImageName) {
                                performMenuItemAction(for: menuItem)
                            }
                            .tint(.blue)
                        }
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 20, weight: .bold))
                            .tint(.blue)
                            .frame(width: 35, height: 35)
                            .background(.white)
                            .clipShape(.circle)
                    }
                    .opacity(isShow ? 1 : 0)
                }

                Slider(value: $opacitySliderValue, in: 0...1) { isEditing in
                    isEditingOpacitySlider = isEditing
                }
                .tint(.blue)
                .frame(maxWidth: .infinity)
                .overlay(content: {
                    Text("opacity: \(String(format: "%.2f", opacitySliderValue))")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(isEditingOpacitySlider ? 1 : 0)
                })
                .opacity(isShow ? 1 : 0)
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .offset(x: 0, y: controlsOffset)
        .onAppear {
            controlsOffset = defaults.getControlsYOffset()
        }
    }

    // MARK: - Menu

    private func buildMenuItems() -> [MenuItem] {
        var items: [MenuItem] = [
            .toggleHidingToolbars(currentIsShow: isHideToolbars),
            .activateControlsDragMode,
            .imageContentMode(contentMode: imageContentMode),
            .vAttachSide(currentSide: vAttachSide),
            .hAttachSide(currentSide: hAttachSide),
        ]

        if !imageXOffset.isZero {
            items.append(
                .resetImageXOffset(xOffset: imageXOffset)
            )
        }

        if !imageYOffset.isZero {
            items.append(
                .resetImageYOffset(yOffset: imageYOffset)
            )
        }

        return items
    }

    private func performMenuItemAction(for menuItem: MenuItem) {
        switch menuItem {
        case .resetImageXOffset:
            imageXOffset = 0
            defaults.removeValue(for: .imageXOffset)

        case .resetImageYOffset:
            imageYOffset = 0
            defaults.removeValue(for: .imageYOffset)

        case .vAttachSide(let currentSide):
            vAttachSide = currentSide.toggleValue
            defaults.save(value: vAttachSide.rawValue, key: .verticalAttachSide)

        case .hAttachSide(let currentSide):
            hAttachSide = currentSide.toggleValue
            defaults.save(value: hAttachSide.rawValue, key: .horizontalAttachSide)

        case .toggleHidingToolbars(let currentIsHide):
            isHideToolbars = !currentIsHide
            defaults.save(value: isHideToolbars, key: .isHideToolbars)

        case .imageContentMode(let contentMode):
            imageContentMode = contentMode.toggleValue
            defaults.save(value: imageContentMode.key, key: .imageContentMode)

        case .activateControlsDragMode:
            isControlsDraggingMode = true
        }
    }

    enum MenuItem {
        case resetImageXOffset(xOffset: Double)
        case resetImageYOffset(yOffset: Double)
        case vAttachSide(currentSide: PixelPerfectScreenSui.ImageVAttachSide)
        case hAttachSide(currentSide: PixelPerfectScreenSui.ImageHAttachSide)
        case toggleHidingToolbars(currentIsShow: Bool)
        case imageContentMode(contentMode: ContentMode)
        case activateControlsDragMode

        var id: String {
            switch self {
            case .resetImageXOffset: "resetImageXOffset"
            case .resetImageYOffset: "resetImageYOffset"
            case .vAttachSide(_): "vAttachSide"
            case .hAttachSide(_): "hAttachSide"
            case .toggleHidingToolbars(_): "toggleHidingToolbars"
            case .imageContentMode(_): "imageContentMode"
            case .activateControlsDragMode: "activateControlsDragMode"
            }
        }

        var title: String {
            switch self {
            case .resetImageXOffset(let offset): "Сброс смещения по X (\(Int(offset)))"
            case .resetImageYOffset(let offset): "Сброс смещения по Y (\(Int(offset)))"
            case .vAttachSide(let currentSide):
                "Прикрепить по Y к .\(currentSide.toggleValue.rawValue)"
            case .hAttachSide(let currentSide):
                "Прикрепить по X к .\(currentSide.toggleValue.rawValue)"
            case .toggleHidingToolbars(let currentIsHide):
                "\(currentIsHide ? "Показывать" : "Скрывать") NavBar / TabBar при позиционировании"
            case .imageContentMode(let contentMode):
                "Уст. contentMode = .\(contentMode.toggleValue)"
            case .activateControlsDragMode: "Переместить контролы"
            }
        }

        var systemImageName: String {
            switch self {
            case .resetImageXOffset, .resetImageYOffset:
                return "trash.slash"

            case .vAttachSide(let currentSide):
                if currentSide.toggleValue == .top {
                    return "inset.filled.topthird.square"
                } else {
                    return "inset.filled.bottomthird.rectangle.portrait"
                }

            case .hAttachSide(let currentSide):
                if currentSide.toggleValue == .leading {
                    return "inset.filled.leadinghalf.arrow.leading.rectangle"
                } else {
                    return "inset.filled.trailinghalf.arrow.trailing.rectangle"
                }
                
            case .toggleHidingToolbars(let currentIsHide):
                return currentIsHide ? "eye" : "eye.slash"

            case .imageContentMode(_):
                return "aspectratio"

            case .activateControlsDragMode:
                return "arrow.up.arrow.down"
            }
        }
    }

}

fileprivate struct ImageDraggingInfoView: View {
    var yOffset: CGFloat
    var xOffset: CGFloat
    var vAttachSide: PixelPerfectScreenSui.ImageVAttachSide
    var hAttachSide: PixelPerfectScreenSui.ImageHAttachSide

    var body: some View {
        VStack(alignment: .center) {
            Group {
                Text("x (from \(vAttachSide.rawValue)): \(Int(yOffset))")
                Text("y (from \(hAttachSide.rawValue)): \(Int(xOffset))")
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .background(Color.black.opacity(0.7))
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

}

// MARK: - Nested structures

extension PixelPerfectScreenSui {
    enum ImageVAttachSide: String {
        case top, bottom

        var toggleValue: Self {
            self == .top ? .bottom : .top
        }
    }

    enum ImageHAttachSide: String {
        case leading, trailing

        var toggleValue: Self {
            self == .leading ? .trailing : .leading
        }
    }

    enum ImageDragAxis: String {
        case horizontal, vertical
    }

    var imageAlignment: Alignment {
        switch (vAttachSide, hAttachSide) {
        case (.top, .leading): .topLeading
        case (.top, .trailing): .topTrailing
        case (.bottom, .leading): .bottomLeading
        case (.bottom, .trailing): .bottomTrailing
        }
    }
}

fileprivate class DefaultsWrapper {
    private let defaults: UserDefaults?

    let imageName: String

    init(imageName: String) {
        self.imageName = imageName
        defaults = .init(suiteName: "com.nova.pixelperfect")

        if defaults == nil {
            PixelPerfectScreenSui.printMessage(prefix: "❌", "Не инициализирован UserDefaults")
        }
    }

    func save<T>(value: T, key: DefaultKey) {
        let keyAsString = key.buildKey(for: imageName)
        defaults?.setValue(value, forKey: keyAsString)
    }

    func getImageXOffset() -> Double {
        let key = DefaultKey.imageXOffset.buildKey(for: imageName)
        return defaults?.double(forKey: key) ?? 0
    }

    func getImageYOffset() -> Double {
        let key = DefaultKey.imageYOffset.buildKey(for: imageName)
        return defaults?.double(forKey: key) ?? 0
    }

    func getControlsYOffset() -> Double {
        let key = DefaultKey.controlsYOffset.buildKey(for: imageName)
        return defaults?.double(forKey: key) ?? 0
    }

    func getVAttachSide() -> PixelPerfectScreenSui.ImageVAttachSide? {
        let key = DefaultKey.verticalAttachSide.buildKey(for: imageName)
        guard let value = defaults?.string(forKey: key) else { return nil }

        return PixelPerfectScreenSui.ImageVAttachSide(rawValue: value)
    }

    func getHAttachSide() -> PixelPerfectScreenSui.ImageHAttachSide? {
        let key = DefaultKey.horizontalAttachSide.buildKey(for: imageName)
        guard let value = defaults?.string(forKey: key) else { return nil }

        return PixelPerfectScreenSui.ImageHAttachSide(rawValue: value)
    }

    func getImageContentMode() -> ContentMode? {
        let key = DefaultKey.imageContentMode.buildKey(for: imageName)
        guard let value = defaults?.string(forKey: key) else { return nil }

        return ContentMode(key: value)
    }


    func getIsHideToolbars() -> Bool {
        let key = DefaultKey.isHideToolbars.buildKey(for: imageName)
        return defaults?.bool(forKey: key) ?? false
    }

    func removeValue(for key: DefaultKey) {
        let key = key.buildKey(for: imageName)
        defaults?.removeObject(forKey: key)
    }

    enum DefaultKey: String {
        case imageYOffset
        case imageXOffset
        case verticalAttachSide
        case horizontalAttachSide
        case imageContentMode
        case isHideToolbars
        case controlsYOffset

        func buildKey(for imageName: String) -> String {
            "\(imageName)_\(self.rawValue)"
        }
    }

}

// MARK: - Extensions

fileprivate extension View {
    @ViewBuilder
    func ppsNavigationBarHidden(_ isHide: Bool) -> some View {
        if #available(iOS 16.0, *) {
            self.toolbar(isHide ? .hidden : .automatic, for: .navigationBar)
        } else {
            self.navigationBarHidden(isHide)
        }
    }

    @ViewBuilder
    func ppsTabBarHidden(_ isHide: Bool) -> some View {
        if #available(iOS 16.0, *) {
            self.toolbar(isHide ? .hidden : .automatic, for: .tabBar)
        } else {
            self
        }
    }
}

fileprivate extension DragGesture.Value {
    var mainDragAxis: PixelPerfectScreenSui.ImageDragAxis {
        abs(self.translation.height) > abs(self.translation.width) ? .vertical : .horizontal
    }
}

fileprivate extension ContentMode {
    static let keyFit = "fit"
    static let keyFill = "fill"

    var key: String {
        switch self {
        case .fit: Self.keyFit
        case .fill: Self.keyFill
        }
    }

    var toggleValue: Self {
        self == .fill ? .fit : .fill
    }

    init?(key: String) {
        switch key {
        case Self.keyFit:
            self = .fit
        case Self.keyFill:
            self = .fill
        default:
            return nil
        }
    }
}

// MARK: - Preview

//struct VacancyDetailScreenPPS_Previews: PreviewProvider {
//
//    struct Container: View {
//        @State private var path = [String]()
//
//        var body: some View {
//            NavigationStack(path: $path) {
//                EmptyView()
//                    .navigationDestination(for: String.self) { view in
//                        VacancyDetailScreen()
//                    }
//                    .onAppear {
//                        path.append("VacancyDetail")
//                    }
//            }
//        }
//    }
//
//    static var previews: some View {
//        Container()
//    }
//}

