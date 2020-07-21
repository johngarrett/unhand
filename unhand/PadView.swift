import SwiftUI

struct PadView: View {
    @State private var showHistorySheet: Bool = false
    var storedItems = [Item]()
    
    var body: some View {
        VStack {
            ItemsList()
            Button("HISTORY") {
                self.showHistorySheet = true
            }.popover(
                isPresented: self.$showHistorySheet
            ) {
                Text("History Popover")
            }
            .font(.system(size: 14, weight: .heavy))
        }
        .padding(.all, 10)
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
