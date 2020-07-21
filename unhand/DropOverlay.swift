import SwiftUI

struct DropOverlay: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Drop Here!")
                .font(.system(size: 20, weight: .bold))
            DropBox()
        }
    }
}
struct DropBox: View {
    var body: some View {
        Image(systemName: "cube.box")
            .font(.system(size: 40, weight: .medium))
    }
}

struct DropOverlay_Previews: PreviewProvider {
    static var previews: some View {
        DropOverlay()
    }
}
