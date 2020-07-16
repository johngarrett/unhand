import SwiftUI

struct PadView: View {
    var heldItems = [Item]()

    init(with items: [Item] = []) {
        self.heldItems = items
    }
    
    var body: some View {
        VStack {
            DroppedItems(heldItems)
        }
    }
}

struct DroppedItems: View {
    @State private var heldItems = [Item]()
    init (_ items: [Item] = []) {
        self.heldItems = items
    }
    
    var body: some View {
        VStack {
            let empty = heldItems.count == 0
            if empty {
                Text("Drop Items Here!")
            }
            ForEach(self.heldItems) { item in
                HStack {
                    Image(uiImage: item.image ?? UIImage())
                        .resizable()
                    Text(item.name ?? "No name")
                        .onDrag { NSItemProvider(object: item.url! as NSURL) }
                }
            }
            
            Image(systemName: empty ? "cube.box" : "cube.box.fill")
        }.onDrop(
            of: ["public.url"],
            delegate: PadDropDelegate(droppedItems: $heldItems)
        )
    }
}

struct PadView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PadView()
        }
    }
}
