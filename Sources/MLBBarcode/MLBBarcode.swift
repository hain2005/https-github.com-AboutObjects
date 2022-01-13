
import SwiftUI
import UIKit
import Combine


public struct MLBChangedFlag {
    
    public let bcImage: UIImage?

    init(bcImage: UIImage) {
        self.bcImage = bcImage
    }
}
public typealias MLBTicketChangeHandler = (MLBChangedFlag) -> Void
public protocol TicketChangeNotifying {
    func addFlagChangeObserver(_ observer: TicketChangeObserver)
//    func addFlagsUnchangedObserver(_ observer: FlagsUnchangedObserver)
//    func addConnectionModeChangedObserver(_ observer: ConnectionModeChangedObserver)
//    func removeObserver(owner: LDObserverOwner)
//    func notifyConnectionModeChangedObservers(connectionMode: ConnectionInformation.ConnectionMode)
//    func notifyUnchanged()
//    func notifyObservers(oldFlags: [LDFlagKey: FeatureFlag], newFlags: [LDFlagKey: FeatureFlag])
}

public struct TicketChangeObserver {
    //private(set) weak var owner: LDObserverOwner?
    //let flagKeys: [LDFlagKey]
    let ticketChangeHandler: MLBTicketChangeHandler?
    //let flagCollectionChangeHandler: LDFlagCollectionChangeHandler?

    init(ticketChangeHandler: @escaping MLBTicketChangeHandler) {
        self.ticketChangeHandler = ticketChangeHandler
    }


}

public protocol ClientServiceCreating {
//    func makeKeyedValueCache() -> KeyedValueCaching
//    func makeFeatureFlagCache(maxCachedUsers: Int) -> FeatureFlagCaching
//    func makeCacheConverter(maxCachedUsers: Int) -> CacheConverting
//    func makeDeprecatedCacheModel(_ model: DeprecatedCacheModel) -> DeprecatedCache
//    func makeDarklyServiceProvider(config: LDConfig, user: LDUser) -> DarklyServiceProvider
//    func makeFlagSynchronizer(streamingMode: LDStreamingMode, pollingInterval: TimeInterval, useReport: Bool, service: DarklyServiceProvider) -> LDFlagSynchronizing
//    func makeFlagSynchronizer(streamingMode: LDStreamingMode,
//                              pollingInterval: TimeInterval,
//                              useReport: Bool,
//                              service: DarklyServiceProvider,
//                              onSyncComplete: FlagSyncCompleteClosure?) -> LDFlagSynchronizing
    func makeFlagChangeNotifier() -> TicketChangeNotifying
//    func makeEventReporter(service: DarklyServiceProvider) -> EventReporting
//    func makeEventReporter(service: DarklyServiceProvider, onSyncComplete: EventSyncCompleteClosure?) -> EventReporting
//    func makeStreamingProvider(url: URL, httpHeaders: [String: String], connectMethod: String, connectBody: Data?, handler: EventHandler, delegate: RequestHeaderTransform?, errorHandler: ConnectionErrorHandler?) -> DarklyStreamingProvider
//    func makeEnvironmentReporter() -> EnvironmentReporting
//    func makeThrottler(environmentReporter: EnvironmentReporting) -> Throttling
//    func makeErrorNotifier() -> ErrorNotifying
//    func makeConnectionInformation() -> ConnectionInformation
//    func makeDiagnosticCache(sdkKey: String) -> DiagnosticCaching
//    func makeDiagnosticReporter(service: DarklyServiceProvider) -> DiagnosticReporting
//    func makeFlagStore() -> FlagMaintaining
}


@available(iOS 14, macOS 11.0, *)
public struct MLBBarcode {
    
    var barcodeViewModel : BarcodeViewModel?
    private var cancellables = [AnyCancellable]()
    private var myTicket : Ticket
    private var bcimage: UIImage?
    
    
    var ticketChangeNotifier: TicketChangeNotifying?

    public init(ticket : Ticket) {
        myTicket = ticket
        //ticketChangeNotifier = serviceFactory.makeFlagChangeNotifier()
    }

//    public mutating func start() {
//        barcodeViewModel = BarcodeViewModel(myTicket: myTicket)
//        barcodeViewModel?.$bcImage.sink { bcimage in
//
//            self.bcimage = bcimage
//         }.store(in: &cancellables)
//
//    }
    
    mutating public func generateTicket(completionHandler: @escaping (_ image: UIImage) -> Void){
         //.. Code process

        let barcodeViewModel = BarcodeViewModel(myTicket: myTicket)

        barcodeViewModel.$bcImage.sink { bcimage in

            //let error = Error()
            completionHandler(bcimage) // return data & close
        }.store(in: &cancellables)

    }
    
//    public func observe(handler: @escaping MLBTicketChangeHandler) {
//        ticketChangeNotifier.addFlagChangeObserver(TicketChangeObserver(ticketChangeHandler: handler))
//    }

    
}
