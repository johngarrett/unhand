import Foundation
import UIKit

class Item: Identifiable, ObservableObject {
    static func == (lhs: Item, rhs: Item) -> Bool { lhs.id == rhs.id }
    
    let itemProvider: NSItemProvider
    var id = UUID()
    @Published var name: String?
    @Published var url: URL?
    @Published var color: UIColor?
    @Published var image: UIImage?
    /*
     AVFragmentedAsset
     AVURLAsset
     CNContact
     CNMutableContact
     CSLocalizedString
     MKMapItem
     NSAttributedString
     NSMutableString
     NSTextStorage
     NSURL
     NSUserActivity
     PHLivePhoto
     UIColor
     UIImage
     */
    init(_ itemProvider: NSItemProvider, name: String? = nil, url: URL? = nil, color: UIColor? = nil, image: UIImage? = nil) {
        self.itemProvider = itemProvider
        self.name = name
        self.url = url
        self.color = color
        self.image = image
    }
}
