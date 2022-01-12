//
//  Ticket.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import Foundation

public struct Ticket {
    public let BarcodeIndicator : String
    public let BarcodeType : String
    public let Number : String
    public let Section : String
    public let Row : String
    public let Seat : String
    public let BuyerTypeCode : String
    public let PriceScaleCode : String
    public let EventID : String
    public let ScanMediaTypet : String
    public var TOTP : String
    
    public var BarcodeString : String {
        return BarcodeIndicator + BarcodeType
    }
}
