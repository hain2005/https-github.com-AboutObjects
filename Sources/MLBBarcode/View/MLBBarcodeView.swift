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
        }
        .onAppear(perform: startTimer)
    }

    private func loadImage() {
      barcodeImage = barcodeViewModel.generateTicket()
    }
    
    private func startTimer() {
        
        _ = Timer.scheduledTimer(withTimeInterval: TimeInterval(5), repeats: true) { _ in
        
            print("loadimage")
            loadImage()
        }
    }
}

//@available(iOS 13.0.0, *)
//struct MLBBarcodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MLBBarcodeView()
//    }
//}
