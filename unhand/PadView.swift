import SwiftUI

struct PadView: View {
    @State private var showHistorySheet: Bool = false
    var storedItems = [Item]()
    
    var body: some View {
        GeometryReader { geomtry in
            VStack {
                ItemsList()
            }
            .padding(.all, 10)
            .frame(width: geomtry.size.width, height: geomtry.size.height)
        }
    }
}

struct PadView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PadView()
            ItemBlob(item:
                        Item(
                            NSItemProvider(),
                            name: "spotify uri",
                            url: URL(string: "https;/as;ljoifjsdaoijsadio")
                        )
            )
        }
    }
}
