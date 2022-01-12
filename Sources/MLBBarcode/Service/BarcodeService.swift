//
//  BarcodeService.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import Foundation

class BarcodeService {
    let url: URL = URL(fileURLWithPath: "")

    public init() {
      
    }

    // 1
    public func fetch(ticketNumber: String) -> String? {
        
        return "test"
//      URLSession.shared.dataTask(with: url) { (data, _, _) in
//        guard let data = data else { return }
//        DispatchQueue.main.async {
//          return data
//        }
//      }.resume()
//
//        return nil
    }

}
