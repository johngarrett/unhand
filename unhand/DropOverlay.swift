import SwiftUI

struct DropOverlay: View {
    @State var incomingItem: DropInfo!
    
    init?(_ info: DropInfo?) {
        guard let info = info else {
            return nil
        }
        self.incomingItem = info
    }

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Drop Here!")
                    .font(.system(size: 20, weight: .bold))
                DropBox()
            }.zIndex(0)
            IncomingRect(incomingItem: $incomingItem).zIndex(1.0)
        }
        .background(Rectangle().fill(Color.white))
    }
}

struct IncomingRect: View {
    @Binding var incomingItem: DropInfo?
    
    var body: some View {
        if let location = incomingItem?.location {
            Rectangle()
                .position(x: location.x, y: location.y)
        }
    }
}

struct DropBox: View {
    var body: some View {
        Image(systemName: "cube.box")
            .font(.system(size: 40, weight: .medium))
    }
}
