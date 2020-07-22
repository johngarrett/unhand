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
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 10) {
                if padState == .dragEntered {
                    DropOverlay(incomingItem)
                } else {
                    ForEach(self.items) { item in
                        ItemBlob(item: item)
                            .padding(.all, 10)
                            .frame(minWidth: geo.size.width, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

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
}

struct ItemBlob: View {
    @ObservedObject var item: Item
    
    var body: some View {
        HStack {
            if let image = item.image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(8)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100)
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
