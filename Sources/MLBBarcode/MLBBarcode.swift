import SwiftUI

public struct MLBBarcode {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    @available(iOS 14, macOS 11.0, *)
    public func getBarCode() -> Image {
        return Image(systemName: "heart.fill")
    }
}
