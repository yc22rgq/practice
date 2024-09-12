import SwiftUI
import WebKit
import Network

struct FasInsterView: View {
    @State private var urlString: String? = UserDefaults.standard.string(forKey: "versionNumber")
    @State private var isConnected = true
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            if let urlString = urlString, let url = URL(string: urlString) {
                WebView(url: url)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Connection Issue"),
                            message: Text("Please connect to the internet to continue."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
            } else {
                Text("Invalid URL")
                    .foregroundColor(.red)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            setupInternetConnectionMonitor()
        }
    }
    
    private func setupInternetConnectionMonitor() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { pathUpdateHandler in
            DispatchQueue.main.async {
                isConnected = pathUpdateHandler.status == .satisfied
                showAlert = !isConnected
            }
        }
        
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = true
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Здесь можно добавить код для обновления представления, если нужно
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            let popupWebView = WKWebView(frame: webView.bounds, configuration: configuration)
            popupWebView.uiDelegate = self
            webView.addSubview(popupWebView)
            return popupWebView
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("Failed provisional navigation: \(error.localizedDescription)")
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("Failed navigation: \(error.localizedDescription)")
        }

        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            webView.reload()
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
    }
}

struct FasInsterView_Previews: PreviewProvider {
    static var previews: some View {
        FasInsterView()
    }
}
