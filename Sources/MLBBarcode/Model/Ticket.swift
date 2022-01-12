//
//  Ticket.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import Foundation

public struct Ticket {
    let BarcodeIndicator : String
    let BarcodeType : String
    let Number : String
    let Section : String
    let Row : String
    let Seat : String
    let BuyerTypeCode : String
    let PriceScaleCode : String
    let EventID : String
    let ScanMediaTypet : String
    var TOTP : String
    
    var BarcodeString : String {
        return BarcodeIndicator + BarcodeType
    }
}
