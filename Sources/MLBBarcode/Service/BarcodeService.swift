//
//  BarcodeService.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import Foundation

enum DownloadError: Error {
  case statusNotOk
  case decoderError
}

@available(iOS 13.0.0, *)
class BarcodeService {

    private var url: URL {
      // swiftlint:disable:next force_unwrapping
      urlComponents.url!
    }

    private var urlComponents: URLComponents {
      var components = URLComponents()
      components.scheme = "https"
      components.host = "api.mlb...."
      components.path = "/sharedsecret"
      return components
    }
    public init() {
      
    }

    public func fetch(ticketNumber: String) -> String? {
        
        return String(Int.random(in: 1..<10000))

    }

    @available(iOS 15.0.0, *)
    func load() async throws -> BarcodeReponse {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else {
            throw DownloadError.statusNotOk
        }
        guard let decodedResponse = try? JSONDecoder().decode(BarcodeReponse.self, from: data)
        else {
            throw DownloadError.decoderError
        }
        return decodedResponse
    }
}
