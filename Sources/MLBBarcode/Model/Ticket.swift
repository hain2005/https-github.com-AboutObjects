//
//  Ticket.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import Foundation

public struct Ticket {
    public let barcodeIndicator : String = ""
    public let barcodeType : String = ""
    public let ticketNumber : String
    public let section : String = ""
    public let row : String = ""
    public let seat : String = ""
    public let buyerTypeCode : String = ""
    public let priceScaleCode : String = ""
    public let eventID : String = ""
    public let scanMediaTypet : String = ""
    public var TOTP : String = ""
    
    public var barcodeString : String {
        return barcodeIndicator + ticketNumber + TOTP
    }
    public init(ticketNumber: String) {
        self.ticketNumber = ticketNumber
    }
}
