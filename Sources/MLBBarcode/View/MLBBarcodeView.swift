//
//  MLBBarcodeView.swift
//  
//
//  Created by Hai Nguyen on 1/12/22.
//

import SwiftUI


@available(iOS 13.0.0, *)
public struct MLBBarcodeView<Content: View>: View {
    
    var content: (_ image: Image) -> Content
    let placeHolder: Image = Image("PDF417")
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var currentCount = 0
    let timeInterval = 5

    @ObservedObject var barcodeViewModel: BarcodeViewModel
    @State var barcodeImage: UIImage?

    public init(
        barcodeViewModel: BarcodeViewModel,
        content: @escaping (_ image: Image) -> Content
    ) {
        self.barcodeViewModel = barcodeViewModel
        self.content = content
    }

    public var body: some View {
        let image = barcodeImage != nil ? Image(uiImage: barcodeImage!) : nil;

        return VStack() {
            Text("Barcode Scan Helper")
                 .padding()
           if image != nil {
                content(image!)
            } else {
                content(placeHolder)
            }

            Text("Refresh in \(timeInterval - currentCount) secs ")
        }
        .onReceive(timer) { input in
            currentCount += 1
            if currentCount == timeInterval {
                loadImage()
                currentCount = 0
            }
        }
    }

    private func loadImage() {
        barcodeImage = barcodeViewModel.generateTicket()
    }
}

//@available(iOS 13.0.0, *)
//struct MLBBarcodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MLBBarcodeView()
//    }
//}
