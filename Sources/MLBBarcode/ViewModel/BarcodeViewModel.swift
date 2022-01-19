//
//  BarcodeViewModel.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import Combine
import SwiftUI
import SwiftOTP

public protocol BarcodeViewModelProtocol {
    func generateTicket() -> UIImage?
}

@available(iOS 13, macOS 11.0, *)
public class BarcodeViewModel: ObservableObject {
    
    @Published var imageData = Data()
    @Published var bcImage = UIImage()
    
    let barcodeService: BarcodeService
    var patronId: Int
    var ticket: Ticket
    let timeStep = 30 // secs for testing for rotating bc - to be loaded from service
    
    public init(barcodeService: BarcodeService, patronId: Int, myTicket: Ticket) {
        self.barcodeService = barcodeService
        self.patronId = patronId
        self.ticket = myTicket
    }

    public func fetch(ticketNumber: String) -> CIImage? {
        let sharedSecret = barcodeService.fetch(patronId: 0, ticketNumber: ticketNumber)
        guard let totp = getTOTP(secretKey: sharedSecret) else {
            return nil
        }
        ticket.TOTP = totp
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
    
    func getTOTP(secretKey: String) -> String? {
        let inputData = Data(secretKey.utf8)
        let totp = TOTP(secret: inputData, digits: 6, timeInterval: timeStep, algorithm: .sha1)
        return totp?.generate(secondsPast1970: Int(NSDate().timeIntervalSince1970))
    }
    
    private func createBC(from string: String, descriptor: Descriptor, size: CGSize) -> CIImage? {
    
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
        let transform = CGAffineTransform(scaleX: size.width / imageSize.width, y: size.height / imageSize.height)
        let scaledImage = image.transformed(by: transform)
        return scaledImage
    }
    
    private func convertCIImageToUIImage(ciimage : CIImage) -> UIImage{
        let context : CIContext = CIContext.init(options: nil)
        let cgImage : CGImage = context.createCGImage(ciimage, from: ciimage.extent)!
        let image : UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
}

