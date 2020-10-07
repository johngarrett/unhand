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
        VStack(spacing: 10) {
            Text("Drop Here!")
                .font(.system(size: 20, weight: .bold))
            DropBox()
        }
        .background(
            Rectangle()
                .fill(Color.white)
                .scaledToFill()
        )
//            IncomingRect(incomingItem: $incomingItem)
//                .zIndex(1.0)
        
    }
}

struct IncomingRect: View {
    @Binding var incomingItem: DropInfo!
    
    var body: some View {
        Rectangle()
            .position(x: incomingItem.location.x, y: incomingItem.location.y)
    }
}

struct DropBox: View {
    var body: some View {
        Image(systemName: "cube.box")
            .font(.system(size: 40, weight: .medium))
    }
}
