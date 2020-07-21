import SwiftUI

struct PadView: View {
    var storedItems = [Item]()
    
    var body: some View {
        ItemsList(
            [
                Item(name: "Spotify", url: URL(string: "www.google.com"))
            ]
        ).padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
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
        VStack(alignment: .center) {
            if padState == .dragEntered {
                DropHereOverlay()
            } else {
                ForEach(self.items) { item in
                    ItemBlob(item: item)
                }
                Text("Drop Items Here!")
                    .font(.system(size: 20, weight: .bold))
                Image(systemName: items.count == 0 ? "cube.box" : "cube.box.fill")
                    .font(.system(size: 40, weight: .medium))
            }
        }
        .onDrop(
            of: ["public.item"],
            delegate: PadDropDelegate(padState: $padState, droppedItems: $items)
        )
    }
}

struct DropHereOverlay: View {
    var body: some View {
        VStack {
            Text("Drop Here!")
                .font(.system(size: 20, weight: .bold))
            Image(systemName: "cube.box")
                .font(.system(size: 40, weight: .medium))
        }
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
            VStack {
                Text(item.name ?? "")
                Divider()
                    .frame(height: 4)
                    .background(Color.black)
                Text(item.url?.absoluteString.removingPercentEncoding ?? "NO URL")
            }
        }
        .padding()
        .border(Color.black, width: 4)
        .cornerRadius(8)
    }
}

struct PadView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PadView()
        }
    }
}
