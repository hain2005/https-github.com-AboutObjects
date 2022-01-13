
import SwiftUI
import UIKit
import Combine

@available(iOS 14, macOS 11.0, *)
public struct MLBBarcode {
    
    var barcodeViewModel : BarcodeViewModel?
    private var cancellables = [AnyCancellable]()
    private var myTicket : Ticket
    private var bcimage: UIImage?
    
    public init(ticket : Ticket) {
        myTicket = ticket
    }

    mutating public func generateTicket(completionHandler: @escaping (_ image: UIImage) -> Void){
 
        let barcodeViewModel = BarcodeViewModel(myTicket: myTicket)
            barcodeViewModel.$bcImage.sink { bcimage in
            completionHandler(bcimage) // return data & close
        }.store(in: &cancellables)

    }
}
