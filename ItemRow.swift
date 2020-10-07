import SwiftUI

struct ItemRow: View {
    @ObservedObject var item: Item
    
    var body: some View {
        HStack {
            if let image = item.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(CGSize(width: image.size.width, height: image.size.height), contentMode: .fit)
                    .cornerRadius(8)
                    .frame(maxHeight: image.size.width * (image.size.height/image.size.width))
            }
            VStack(spacing: 10) {
                if let name = item.name {
                Text(name)
                    .font(.system(size: 16, weight: .bold))
                }
                if let url = item.url?.absoluteString.removingPercentEncoding {
                    HStack {
                        Image(systemName: "link")
                            .font(.system(.caption, design: .monospaced))
                        Text(url)
                            .font(.system(.caption, design: .monospaced))
                            .lineLimit(5)
                    }
                }
            }
        }
        .padding()
        .border(Color.black, width: 4)
        .frame(maxWidth: .infinity)
    }
}
