import SwiftUI

struct PadView: View {
    var items = [Item]()

    init(with items: [Item] = []) {
        self.items = items
    }
    
    var body: some View {
        ItemsList(items)
    }
}

struct ItemsList: View {
    @State private var items = [Item]()
    init (_ items: [Item] = []) {
        self.items = items
    }
    
    var body: some View {
        VStack {
            let empty = items.count == 0
            if empty {
                Text("Drop Items Here!")
            }
            ForEach(self.items) { item in
                HStack {
                    Image(uiImage: item.image ?? UIImage())
                        .resizable()
                    Text(item.name ?? "No name")
                        .onDrag { NSItemProvider(object: item.url! as NSURL) }
                }
            }
            
            Image(systemName: empty ? "cube.box" : "cube.box.fill")
                .font(.largeTitle)
        }
        .onDrop(
            of: ["public.url"],
            delegate: PadDropDelegate(droppedItems: $items)
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
