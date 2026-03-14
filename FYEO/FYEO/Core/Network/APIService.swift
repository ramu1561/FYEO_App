import Foundation

protocol APIServiceProtocol {
    func request<T: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T, Error>) -> Void
    )
    func execute<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}

class APIService: APIServiceProtocol {
    static let shared = APIService()
    
    private let session: URLSession

    private init() {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config, delegate: UnsafeSessionDelegate(), delegateQueue: nil)
    }

    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: endpoint.urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // MARK: - Request Logs
        print("URL:", url.absoluteString)
        print("Method:", request.httpMethod ?? "")

        if let headers = request.allHTTPHeaderFields {
            print("Headers:", headers)
        }

        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("Request Params:", bodyString)
        }
        
        session.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Error:", error)
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code:", httpResponse.statusCode)
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "NoData", code: -1)))
                    return
                }

                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response:", responseString)
                }
                
                do{
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                }
                catch{
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}

class UnsafeSessionDelegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if let serverTrust = challenge.protectionSpace.serverTrust {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

extension APIServiceProtocol {
    func execute<T: Decodable>(endpoint: Endpoint,
        completion: @escaping (Result<T, Error>) -> Void) {
        self.request(endpoint: endpoint) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
