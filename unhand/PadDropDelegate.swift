import Foundation
import SwiftUI
import UIKit

struct PadDropDelegate: DropDelegate {
    @Binding var dragIncoming: Bool
    @Binding var droppedItems: [Item]
    @Binding var incomingItem: DropInfo?
   
    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .copy)
    }
    
    func validateDrop(info: DropInfo) -> Bool {
        info.hasItemsConforming(to: Item.avaliableUTIs)
    }

    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: ["public.item"]) else {
            print("Does not conform to type public.item")
            return false
        }
        let items = info.itemProviders(for: ["public.item"])
        
        items.forEach { item in
            
            let droppedItem = Item(item)
//
//            for uti in Item.avaliableUTIs {
//                item.loadItem(forTypeIdentifier: uti, options: nil) { result, error in
//                    print(result)
//                    print(error)
//                    print(uti)
//                }
//            }
            
            let _ = item.loadObject(ofClass: String.self) { string, error in
                if let string = string {
                    DispatchQueue.main.async {
                        droppedItem.name = string
                    }
                }
            }
            
            let _ = item.loadObject(ofClass: URL.self) { url, error in
                if let url = url {
                    DispatchQueue.main.async {
                        droppedItem.url = url
                    }
                }
            }
            
            let _ = item.loadObject(ofClass: UIImage.self) { image, error in
                if let image = image as? UIImage {
                    print("loaded image")
                    DispatchQueue.main.async {
                        droppedItem.image = image
                    }
                }
            }
            
            self.droppedItems.append(droppedItem)
        }
        
        dragIncoming = false
        return true
    }
    
    func dropEntered(info: DropInfo) {
        dragIncoming = true
        incomingItem = info
    }
    
    func dropExited(info: DropInfo) {
        dragIncoming = false
        print("DOP exited")
    }
}
