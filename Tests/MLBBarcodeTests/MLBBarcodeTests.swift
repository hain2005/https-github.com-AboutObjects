import XCTest
import SwiftUI
@testable import MLBBarcode

final class MLBBarcodeTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(MLBBarcode().text, "Hello, World!")
        
        let ticket = Ticket(ticketNumber: "123456")
        if #available(iOS 14, *) {
            //let barCodeImage: Image?
            //let serviceFactory = ClientServiceCreating()
            var mblBarcode = MLBBarcode(ticket: ticket)
            
            mblBarcode.generateTicket { image in
                _ = image
            }
//            if let image = mblBarcode.generateTicket() {
//                //barCodeImage = Image(uiImage: image)
//            }
//            else {
//                //barCodeImage = Image("PDF417")
//            }
        } else {
            // Fallback on earlier versions
        }
        

    }
}
