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
    let timeInterval = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @ObservedObject var barcodeViewModel: BarcodeViewModel
    @State var barcodeImage: UIImage?
    @State var currentCount = 0

    @State private var xVal: CGFloat = 0.0
    @State private var timerVLine = Timer.publish(every: 0.005, on: .main, in: .common).autoconnect()
    @State private var isMovingRight = true

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
                GeometryReader { geo in
                    content(image!)
                    ZStack(alignment: .leading) {
                        //Image("vLine")
                        Image(packageResource: "vLine", ofType: "png")
                            .resizable()
                            .offset(x: xVal, y: 0)
                            .transition(.slide)
                            .padding(.leading , 0)
                            .onReceive(timerVLine) {_ in
                                if isMovingRight {
                                    xVal += 1
                                    if xVal == geo.size.width {
                                         isMovingRight = false
                                    }
                                }
                                else {
                                    xVal -= 1
                                    if xVal == 0 {
                                         isMovingRight = true
                                    }

                                }
                            }
                            .frame(width: 5, height: 165, alignment: .leading)
                    }
                }

            } else {
                if #available(iOS 14.0, *) {
                    ProgressView()
                } else {
                    // Fallback on earlier versions
                    Text("Please wait ...")
                } //content(placeHolder)
            }
            Text("Refresh in \(timeInterval - currentCount) secs ")
                .padding(.top, 5)
        }
        .onAppear {
            loadImage()
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

@available(iOS 13.0.0, *)
struct MLBBarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        let ticket = Ticket(ticketNumber: "12345")
        let barcodeViewModel = BarcodeViewModel(myTicket: ticket)

        return VStack {
            MLBBarcodeView(barcodeViewModel: barcodeViewModel) {
              $0
                .resizable()
                .scaledToFit()
                .animation(.easeInOut(duration: 1.0))
            }
        }
    }
}

@available(iOS 13.0, *)
extension Image {
    init(packageResource name: String, ofType type: String) {
//        #if canImport(UIKit)
//        guard let path = Bundle.module.path(forResource: name, ofType: type),
//              let image = UIImage(contentsOfFile: path) else {
//            self.init(name)
//            return
//        }
//        self.init(uiImage: image)
        #if canImport(AppKit)
        guard let path = Bundle.module.path(forResource: name, ofType: type),
              let image = NSImage(contentsOfFile: path) else {
            self.init(name)
            return
        }
        self.init(nsImage: image)
        #else
        self.init(name)
        #endif
    }
}
