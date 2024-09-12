import SwiftUI
import AppTrackingTransparency
import AdSupport
import AppsFlyerLib

struct InsiVectorView: View {
    @State private var isLoadingComplete = false
    @State private var backgroundImage: UIImage?
    
    var body: some View {
        ZStack {
            if isLoadingComplete {
                ContentView()
                    .transition(.opacity)
            } else {
                // Показ экрана загрузки (InsiVector)
                Image(uiImage: backgroundImage ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        startLoading()
                        updateIfNeeded()
                    }
            }
        }
    }
    
    private func startLoading() {
        backgroundImage = UIImage(named: "1 6.5")
    }
    
    private func updateIfNeeded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ATTrackingManager.requestTrackingAuthorization { status in
                if status == .authorized {
                    self.isLoadingComplete = true
                    AppsFlyerLib.shared().start()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.isLoadingComplete = true
                        AppsFlyerLib.shared().start()
                    }
                }
            }
        }
    }
}

class AppsFlyerDelegateHandler: NSObject, AppsFlyerLibDelegate {
    private let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
        
        // Настройка Appsflyer
        let appsflyerLib = AppsFlyerLib.shared()
        appsflyerLib.appsFlyerDevKey = "yourdevkey"
        appsflyerLib.appleAppID = "yourappid"
        
        // Настройка Deep Linking (если требуется)
        appsflyerLib.waitForATTUserAuthorization(timeoutInterval: 60)
    }
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        print("onConversionDataSuccess:", conversionInfo)
    }
    
    func onConversionDataFail(_ error: Error) {
        print("onConversionDataFail:", error.localizedDescription)
    }
    
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        print("onAppOpenAttribution:", attributionData)
    }
    
    func onAppOpenAttributionFailure(_ error: Error) {
        print("onAppOpenAttributionFailure:", error.localizedDescription)
    }
}

