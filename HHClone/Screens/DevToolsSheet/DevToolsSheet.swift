import SwiftUI

struct DevToolsSheet: View {
    @State private var selectedStage: APIStage = .current

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Picker("API Host", selection: $selectedStage) {
                        ForEach(APIStage.allCases, id: \.rawValue) { stage in
                            Text("\(stage.title)").tag(stage)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
            }
            .navigationTitle("DevTools")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
        .tint(.white)
        .onChange(of: selectedStage) {
            APIStage.current = selectedStage
        }
    }

}

fileprivate extension APIStage {
    var title: String {
        "\(rawValue) (\(apiHost))"
    }
}

// MARK: - Preview

struct DevToolsSheet_Preview: PreviewProvider {

    struct Container: View {
        @State private var isShowSheet: Bool = true

        var body: some View {
            ZStack {
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .sheet(isPresented: $isShowSheet) {
                DevToolsSheet()
            }
        }
    }

    static var previews: some View {
        Container()
    }

}

