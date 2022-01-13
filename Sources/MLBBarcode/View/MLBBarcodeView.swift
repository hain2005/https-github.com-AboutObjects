//
//  MLBBarcodeView.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import SwiftUI


@available(iOS 13.0.0, *)
public struct MLBBarcodeView<Content: View>: View {
    @ObservedObject var barcodeViewModel: BarcodeViewModel
    var content: (_ image: Image) -> Content
    let placeHolder: Image
    let ticket: Ticket

    @State var previousURL: URL? = nil
    @State var imageData: UIImage? //Data = Data()

    public init(
        ticket: Ticket,
        placeHolder: Image,
        barcodeViewModel: BarcodeViewModel,
        content: @escaping (_ image: Image) -> Content
    ) {
        self.ticket = ticket
        self.placeHolder = placeHolder
        self.barcodeViewModel = barcodeViewModel
        self.content = content
    }

    public var body: some View {
//        DispatchQueue.main.async {
////            if (self.previousURL != self.imageFetcher.getUrl()) {
////                self.previousURL = self.imageFetcher.getUrl()
////            }
//
//            if (!self.barcodeViewModel.imageData.isEmpty) {
//                self.imageData = self.barcodeViewModel.imageData
//            }
//        }

        //let uiImage = imageData.isEmpty ? nil : UIImage(data: imageData)
        
        let image = imageData != nil ? Image(uiImage: imageData!) : nil;


        return VStack() {
            Text("Barcode Scan Helper")
                 .padding()

           if image != nil {
                content(image!)
            } else {
                content(placeHolder)
            }
        }
        .onAppear(perform: startTimer)
    }

    private func loadImage() {
      imageData = barcodeViewModel.generateTicket(myTicket: ticket)
    }
    
    private func startTimer() {
        
        _ = Timer.scheduledTimer(withTimeInterval: TimeInterval(5), repeats: true) { _ in
        
            print("loadimage")
                    loadImage()
        //            if let image = self.generateTicket(myTicket: self.ticket) {
        //                self.bcImage = image
        }

    }
//    private func loadImage() {
//        let ticket = Ticket(ticketNumber: "123456")
//
//        var mblBarcode = MLBBarcode(ticket: ticket)
//        mblBarcode.generateTicket { image in
//            barCodeImage = Image(uiImage: image)
//        }
//
//     }
    
}

//@available(iOS 13.0.0, *)
//struct MLBBarcodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MLBBarcodeView()
//    }
//}
