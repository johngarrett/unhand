import SwiftUI

enum PadState {
    case idle
    case dragEntered
}

struct ItemsList: View {
    @State var padState: PadState = .idle
    @State private var items = [Item]()
    @State private var incomingItem: DropInfo? = nil

    init (_ items: [Item] = []) {
        self.items = items
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if padState == .dragEntered {
                DropOverlay(incomingItem)
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
            delegate: PadDropDelegate(padState: $padState, droppedItems: $items, incomingItem: $incomingItem)
        )
    }
}

struct ItemBlob: View {
    let item: Item
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