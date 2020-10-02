import Foundation
import SwiftUI
import UIKit

struct PadDropDelegate: DropDelegate {
    @Binding var padState: PadState
    @Binding var droppedItems: [Item]
    @Binding var incomingItem: DropInfo?

    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: ["public.item"]) else {
            print("Does not conform to type public.item")
            return false
        }
        let items = info.itemProviders(for: ["public.item"])
        for item in items {
            let droppedItem = Item(item)
            item.loadObject(ofClass: String.self) { string, error in
                if let string = string {
                    DispatchQueue.main.async {
                        droppedItem.name = string
                    }
                }
            }
            
            item.loadObject(ofClass: URL.self) { url, error in
                if let url = url {
                    DispatchQueue.main.async {
                        droppedItem.url = url
                    }
                }
            }
            
            item.loadObject(ofClass: UIImage.self) { image, error in
                    if let image = image as? UIImage {
                        print("loaded image")
                        DispatchQueue.main.async {
                            droppedItem.image = image
                        }
                    }
            }
            
            self.droppedItems.append(droppedItem)
        }
        
        padState = .idle
        return true
    }
    
    func dropEntered(info: DropInfo) {
        padState = .dragEntered
        incomingItem = info
    }
    
    func dropExited(info: DropInfo) {
//        padState = .idle
        print("DOP exited")
    }
}
