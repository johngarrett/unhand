import SwiftUI

struct PadView: View {
    @State var dragIncoming: Bool = false
    @State private var incomingItem: DropInfo? = nil
    @State private var showHistorySheet: Bool = false
    @State var items = [Item]()
    
    var body: some View {
        ZStack {
            if dragIncoming {
                DropOverlay(incomingItem)
                    .scaledToFill()
                    .zIndex(1)
            }
            if items.isEmpty {
                VStack(spacing: 20) {
                    Text("Drop items here!")
                        .font(.title)
                        .foregroundColor(.primary)
                    Image(systemName:"cube.box")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                }.frame(maxHeight: .infinity)
            } else {
                VStack(spacing: 20) {
                    Text("Drop more items here")
                        .font(.title)
                        .foregroundColor(.secondary)
                    Image(systemName: "cube.box.fill")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    ScrollView {
                        ForEach(items.reversed(), id: \.self) { item in
                            ItemRow(item: item)
                                .onDrag { NSItemProvider(object: item) }
                        }
                    }
                }
            }
        }
        .onDrop(
            of: ["public.item"],
            delegate: PadDropDelegate(
                dragIncoming: $dragIncoming,
                droppedItems: $items,
                incomingItem: $incomingItem
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
