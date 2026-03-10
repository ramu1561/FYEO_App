//
//  APIClient.swift
//  FYEO
//
//  Created by Harvi Jivani on 07/03/26.
//

import Foundation

//Handles network requests
class APIClient {

    static let shared = APIClient()

    func request<T: Decodable>(router: APIRouter,
                               responseType: T.Type,
                               completion: @escaping(Result<T, Error>) -> Void) {

        let urlString = router.baseURL + router.path

        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = router.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let params = router.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decoded))

            } catch {
                completion(.failure(error))
            }

        }.resume()

    }

}
