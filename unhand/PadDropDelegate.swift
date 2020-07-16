import Foundation
import SwiftUI
import UIKit

struct PadDropDelegate: DropDelegate {
    @Binding var droppedItems: [Item]

    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: ["public.item"]) else {
            print("Does not conform to type public.item")
            return false
        }
        let items = info.itemProviders(for: ["public.item"])
        for item in items {
            let droppedItem = Item()
            droppedItem.name = item.suggestedName
            
            item.loadItem(forTypeIdentifier: "public.image", options: nil) { image, error in
                print("can load image")
                if let encodedImage = image as? UIImage {
                    print("ecnoded")
                    droppedItem.image = encodedImage
                }
            }
            
//            if item.canLoadObject(ofClass: UIImage.self) {
//                item.loadObject(ofClass: UIImage.self) { image, error in
//                    if let _ = image as? UIImage {
//                        print(item.suggestedName)
//                    }
//                }
//            }
            
            item.loadItem(forTypeIdentifier: "public.url", options: nil) { item, error in
                guard let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) else {
                    return
                }
                droppedItem.url = url
            }
            self.droppedItems.append(droppedItem)
        }
        
        return true
    }
    
    func dropEntered(info: DropInfo) {
        print("DOP ENTERRED")
    }
    
    func dropExited(info: DropInfo) {
        print("DOP exited")
    }
}
