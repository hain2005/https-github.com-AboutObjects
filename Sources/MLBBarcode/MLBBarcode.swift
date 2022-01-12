
import SwiftUI
import UIKit

@available(iOS 14, macOS 11.0, *)
public struct MLBBarcode {
    public private(set) var text = "Hello, World!"
    
    let barcodeViewModel : BarcodeViewModel

    private var myTicket : Ticket
    public init(ticket : Ticket) {
        myTicket = ticket
        barcodeViewModel = BarcodeViewModel(myTicket: myTicket)
    }
    
    func generateTicket() -> UIImage? {
        
        if let output = barcodeViewModel.generateTicket(myTicket: myTicket) {
            return UIImage(ciImage: output)
        }
        else {
            return nil
        }
    }
}
