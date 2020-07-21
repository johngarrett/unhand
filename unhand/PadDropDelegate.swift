import Foundation
import SwiftUI
import UIKit

struct PadDropDelegate: DropDelegate {
    @Binding var padState: PadState
    @Binding var droppedItems: [Item]

    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: ["public.item"]) else {
            print("Does not conform to type public.item")
            return false
        }
        let items = info.itemProviders(for: ["public.item"])
        for item in items {
            let droppedItem = Item(item)
            droppedItem.name = item.suggestedName
            
            item.loadObject(ofClass: URL.self) { url, error in
                if let url = url {
                    droppedItem.url = url
                }
            }
            
            item.loadObject(ofClass: UIImage.self) { image, error in
                    if let image = image as? UIImage {
                        print("loaded image")
                        droppedItem.name = item.suggestedName
                        droppedItem.image = image
                    }
            }
            
            
            self.droppedItems.append(droppedItem)
        }
        
        padState = .idle
        return true
    }
    
    func dropEntered(info: DropInfo) {
        padState = .dragEntered
        print("location: \(info.location.x) x \(info.location.y)")
    }
    
    func dropExited(info: DropInfo) {
        padState = .idle
        print("DOP exited")
    }
}
