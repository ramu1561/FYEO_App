import Foundation

class SignInViewModel {

    private let apiService: APIServiceProtocol

    var onLoading: ((Bool) -> Void)?
    var onLoginSuccess: (() -> Void)?
    var onError: ((String) -> Void)?

    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    func validateForm(fields:[AppTextField]) -> Bool {
        var isValid = true
        for field in fields {
            if field.validate() == false {
                isValid = false
            }
        }
        return isValid
    }
    private func performRequest<T: Decodable>(endpoint: Endpoint,onSuccess: @escaping (T) -> Void) {
        onLoading?(true)
        apiService.execute(endpoint: endpoint) { [weak self] (result: Result<T, Error>) in
            self?.onLoading?(false)
            switch result {
            case .success(let response):
                onSuccess(response)
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    func loginWith(phone emailOrPhone: String, password pwd: String) {
        let request = SignInRequest(phone: emailOrPhone, password: pwd)
        let endpoint = Endpoint(path: .loginWithPassword, method: .post, body: try? JSONEncoder().encode(request))
        
        performRequest(endpoint: endpoint) { (response:SignInResponse) in
            if response.status == true{
                self.onLoginSuccess?()
            }
            else{
                self.onError?(response.message ?? "")
            }
        }
    }
}
