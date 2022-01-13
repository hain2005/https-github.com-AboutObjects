//
//  BarcodeViewModel.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import Combine
import SwiftUI
import CryptoKit

@available(iOS 13, macOS 11.0, *)
public class BarcodeViewModel: ObservableObject {
    @Published var imageData = Data()
    @Published var bcImage = UIImage()
    let barcodeService = BarcodeService()
    var ticket: Ticket
    let timePeriod = 5
    var timer : Timer?
    //var cancellable: Cancellable?

    public init(myTicket: Ticket) {
        ticket = myTicket
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timePeriod), repeats: true) { _ in
            
            if let image = self.generateTicket() {
                self.bcImage = image
            }
            
        }
        //timer?.fire()

    }

    deinit {
        timer?.invalidate()
        
    }
    // 1
    public func fetch(ticketNumber: String) -> CIImage? {
        let sharedSecret = barcodeService.fetch(ticketNumber: ticketNumber)
        let timeStamp = NSDate().timeIntervalSince1970
        ticket.TOTP = hashIt(secretKey: sharedSecret ?? "",  timestamp: String(timeStamp))
        
        if let image = createBC(from: ticket.barcodeString,
                                descriptor: .pdf417,
                                     size: CGSize(width: 800, height: 300)) {
            return image
            
        }
        return nil
    }
    
    func generateTicket() -> UIImage? {
        
        if let ciImage = fetch(ticketNumber: ticket.ticketNumber) {
            return convertCIImageToUIImage(ciimage: ciImage)
        }
        else {
            return nil
        }

    }
    
    private func hashIt(secretKey: String, timestamp: String) -> String {
        
        let inputString = secretKey + timestamp
        let inputData = Data(inputString.utf8)
        let hashed = SHA256.hash(data: inputData)
        let totp = hashed.compactMap { String(format: "%02x", $0) }.joined()
        return totp
    }
    
    private func createBC(from string: String,
                          descriptor: Descriptor,
                                size: CGSize) -> CIImage? {
        
        let filterName = descriptor.rawValue

        guard let data = string.data(using: .ascii),
            let filter = CIFilter(name: filterName) else {
                return nil
        }

        filter.setValue(data, forKey: "inputMessage")

        guard let image = filter.outputImage else {
            return nil
        }

        let imageSize = image.extent.size

        let transform = CGAffineTransform(scaleX: size.width / imageSize.width,
                                               y: size.height / imageSize.height)
        let scaledImage = image.transformed(by: transform)

        return scaledImage
        
    }
    
    private func convertCIImageToUIImage(ciimage : CIImage) -> UIImage{
        let context : CIContext = CIContext.init(options: nil)
        let cgImage : CGImage = context.createCGImage(ciimage, from: ciimage.extent)!
        let image : UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    public func getImageData() -> Data {
      return imageData
    }

}

