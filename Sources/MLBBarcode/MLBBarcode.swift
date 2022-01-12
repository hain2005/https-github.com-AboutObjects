
import SwiftUI
import UIKit

@available(iOS 14, macOS 11.0, *)
public struct MLBBarcode {
    
    var barcodeViewModel : BarcodeViewModel

    private var myTicket : Ticket
    public init(ticket : Ticket) {
        myTicket = ticket
        barcodeViewModel = BarcodeViewModel(myTicket: myTicket)
    }
    
    public func generateTicket() -> UIImage? {
        
        if let image = barcodeViewModel.generateTicket(myTicket: myTicket) {
            
            return image
        }
        else {
            return nil
        }
    }
}
