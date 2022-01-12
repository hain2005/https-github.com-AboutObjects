//
//  BarcodeViewModel.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import Combine
import SwiftUI

@available(iOS 14, macOS 11.0, *)
public class BarcodeViewModel: ObservableObject {
    @Published var imageData = Data()
    let barcodeService = BarcodeService()
    var ticket: Ticket
    
    public init(myTicket: Ticket) {
        ticket = myTicket
    }

    // 1
    public func fetch(ticketNumber: String) -> CIImage? {
        let sharedSecret = barcodeService.fetch(ticketNumber: ticketNumber)
        let timeStamp = NSDate().timeIntervalSince1970
        ticket.TOTP = hashIt(string: sharedSecret ?? "" + String(timeStamp))
        return createBC(bcString: ticket.barcodeString)
    }
    
    func generateTicket(myTicket: Ticket) -> CIImage? {
        
        ticket = myTicket
        return fetch(ticketNumber: ticket.ticketNumber)

    }
    
    private func hashIt(string: String) -> String {
        return string
    }
    
    private func createBC(bcString: String) -> CIImage? {
        
        let data = bcString.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                 return output
            }
        }
        return nil
    }
    
}

