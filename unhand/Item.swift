import Foundation
import UIKit

class Item: Identifiable {
    static func == (lhs: Item, rhs: Item) -> Bool { lhs.id == rhs.id }
    
    var id = UUID()
    var name: String?
    var url: URL?
    var color: UIColor?
    var image: UIImage?
    /*
     AVFragmentedAsset
     AVURLAsset
     CNContact
     CNMutableContact
     CSLocalizedString
     MKMapItem
     NSAttributedString
     NSMutableString
     NSString
     NSTextStorage
     NSURL
     NSUserActivity
     PHLivePhoto
     UIColor
     UIImage
     */
    init(name: String? = nil, url: URL? = nil, color: UIColor? = nil, image: UIImage? = nil) {
        self.name = name
        self.url = url
        self.color = color
        self.image = image
    }
}
