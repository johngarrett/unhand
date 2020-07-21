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

enum PadState {
    case idle
    case dragEntered
}

struct ItemsList: View {
    @State var padState: PadState = .idle
    @State private var items = [Item]()
    
    init (_ items: [Item] = []) {
        self.items = items
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if padState == .dragEntered {
                DropOverlay()
            } else {
                ForEach(self.items) { item in
                    ItemBlob(item: item)
                        .padding(.all, 10)
                }
                Text("Drop Items Here!")
                    .font(.system(size: 20, weight: .bold))
                Image(systemName: items.count == 0 ? "cube.box" : "cube.box.fill")
                    .font(.system(size: 40, weight: .medium))
            }
        }
        .scaledToFill()
        .onDrop(
            of: ["public.item"],
            delegate: PadDropDelegate(padState: $padState, droppedItems: $items)
        )
    }
}

struct ItemBlob: View {
    var item: Item
    var body: some View {
        HStack {
            if let image = item.image {
                Image(uiImage: image)
                    .cornerRadius(8)
            }
            VStack(spacing: 10) {
                Text(item.name ?? "")
                    .font(.system(size: 16, weight: .bold))
                Text(item.url?.absoluteString.removingPercentEncoding ?? "NO URL")
                    .font(.system(.body, design: .monospaced))
                    .lineLimit(5)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 4)
        )
        .onDrag {
            item.itemProvider
        }
    }
}

struct PadView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PadView()
            DropOverlay()
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
