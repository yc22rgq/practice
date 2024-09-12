import SwiftUI
import AppsFlyerLib

@main
struct Candy_PocketsApp: App {
    
    init() {
        // Настройка Appsflyer
        let appsflyerLib = AppsFlyerLib.shared()
        appsflyerLib.appsFlyerDevKey = "imB2ax9VBfwdDoJ9ChumUn"
        appsflyerLib.appleAppID = "6670279888"
        
        // Настройка Deep Linking (если требуется)
        appsflyerLib.waitForATTUserAuthorization(timeoutInterval: 60)
    }
    
    var body: some Scene {
        WindowGroup {
            InsiVectorView()
                .onAppear {
                    // Запуск SDK при активации приложения
                    AppsFlyerLib.shared().start()
                }
        }
    }
}
