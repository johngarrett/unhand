import Foundation
import UIKit

class Item: NSObject, Identifiable, ObservableObject {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.name == rhs.name
        && lhs.image == rhs.image
        && lhs.url == rhs.url
    }
    
    unowned var itemProvider: NSItemProvider
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
extension Item: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return ["public.image", "public.url", "public.item"]
    }
    
    func loadData(
        withTypeIdentifier typeIdentifier: String,
        forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void
    ) -> Progress? {
        
        if typeIdentifier == "public.url", let url = url {
            completionHandler(url.dataRepresentation, nil)
        }
        else if typeIdentifier == "public.image", let image = image {
            completionHandler(image.pngData(), nil)
        } else {
            completionHandler(itemProvider.teamData, nil)
        }
        return nil
    }
    
    
}
