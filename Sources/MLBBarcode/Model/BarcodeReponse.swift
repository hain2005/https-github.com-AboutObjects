//
//  BarcodeReponse.swift
//  
//
//  Created by Hai Nguyen on 1/13/22.
//

import Foundation

struct BarcodeReponse: Codable {
    let sharedSecret : String
    let timeStep : Int
    let hashAlgo : Int
}
