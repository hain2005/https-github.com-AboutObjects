
import SwiftUI
import UIKit
import Combine


typealias CompletionHandler = (_ success : UIImage) -> Void

@available(iOS 14, macOS 11.0, *)
public struct MLBBarcode {
    
    var barcodeViewModel : BarcodeViewModel?
    private var cancellables = [AnyCancellable]()
    private var myTicket : Ticket
    public init(ticket : Ticket) {
        myTicket = ticket
     }

    
    mutating public func generateTicket(completionHandler: @escaping (_ image: UIImage) -> Void){
         //.. Code process
        
        barcodeViewModel = BarcodeViewModel(myTicket: myTicket)
        
        barcodeViewModel?.$bcImage.sink { bcimage in
            
            //let error = Error()
            completionHandler(bcimage) // return data & close
        }.store(in: &cancellables)

    }
    
//    public func observe(handler: @escaping LDFlagChangeHandler) {
//        flagChangeNotifier.addFlagChangeObserver(FlagChangeObserver(key: key, owner: owner, flagChangeHandler: handler))
//    }

    
//    mutating func generateTicket(completionHandler: CompletionHandler) {
//
//        // download code.
//        let barcodeViewModel = BarcodeViewModel(myTicket: myTicket)
//
//        barcodeViewModel.$bcImage.sink { image in
//
//            completionHandler(image)
//
//        }
//
//     }

//    public func generateTicket() -> UIImage? {
//
//        if let image = barcodeViewModel.generateTicket(myTicket: myTicket) {
//
//            return image
//        }
//        else {
//            return nil
//        }
//    }
}
