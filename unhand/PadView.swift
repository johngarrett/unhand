import SwiftUI

struct PadView: View {
    var storedItems = [Item]()
    
    var body: some View {
        ItemsList(
            [
                Item(name: "Spotify", url: URL(string: "www.google.com"))
            ]
        )
        .scaledToFit()
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
        VStack {
            if padState == .dragEntered {
                DropHereOverlay()
            } else {
                if items.count == 0 {
                    Text("Drop Items Here!")
                }
                ForEach(self.items) { item in
                    ItemBlob(item: item)
                }
            }
            
            Image(systemName: items.count == 0 ? "cube.box" : "cube.box.fill")
                .font(.largeTitle)
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
            Image(systemName: "cube.box")
                .font(.largeTitle)
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
