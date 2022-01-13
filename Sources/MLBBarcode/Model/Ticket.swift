//
//  Ticket.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import Foundation

public enum Descriptor: String {
    case code128 = "CICode128BarcodeGenerator"
    case pdf417 = "CIPDF417BarcodeGenerator"
    case aztec = "CIAztecCodeGenerator"
    case qr = "CIQRCodeGenerator"
}

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
