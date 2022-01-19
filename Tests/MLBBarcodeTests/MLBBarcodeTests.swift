import XCTest
import SwiftUI

@testable import MLBBarcode

final class MLBBarcodeTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(MLBBarcode().text, "Hello, World!")
        let patronId = 1
        let ticket = Ticket(ticketNumber: "123456")
        if #available(iOS 14, *) {
            let barcodeViewModel = BarcodeViewModel(barcodeService: BarcodeService(), patronId: patronId,  myTicket: ticket)
            
            let image = barcodeViewModel.generateTicket()
            
            XCTAssertNotNil(image)
        } else {
            // Fallback on earlier versions
        }
        

    }
    
    func testTOTP() throws {
        
        let secretKey = "123456678"
        let patronId = 1
        let ticket = Ticket(ticketNumber: "123456")
        if #available(iOS 14, *) {
            let barcodeViewModel = BarcodeViewModel(barcodeService: BarcodeService(), patronId: patronId,  myTicket: ticket)
            
            let totp1 = barcodeViewModel.getTOTP(secretKey: secretKey)
            
            Thread.sleep(forTimeInterval: 1)
            let totp2 = barcodeViewModel.getTOTP(secretKey: secretKey)
            

            XCTAssertEqual(totp1, totp2)
        } else {
            // Fallback on earlier versions
        }

    }
}
