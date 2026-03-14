//
//  VerifyAuthViewModel.swift
//  FYEO
//
//  Created by Harvi Jivani on 12/03/26.
//

import Foundation

class VerifyAuthViewModel {

    private let apiService: APIServiceProtocol

    var onLoading: ((Bool) -> Void)?
    var onVerifySuccess: (() -> Void)?
    var onError: ((String) -> Void)?

    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
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
    
    //MARK: Verify Registration API
    func verifyRegistrationAPI(phone: String, otp: String) {
        
        let request = VerifyAuthRequest(phone: phone,otp: otp)
        let endpoint = Endpoint(path: .verifyRegistration,method: .post,body: try? JSONEncoder().encode(request))

        self.performRequest(endpoint: endpoint) { (response:RegisterResponse) in
            if response.status == true{
                self.onVerifySuccess?()
            }
            else{
                self.onError?(response.message ?? "")
            }
        }
    }
    
    //MARK: Send OTP API
    func loginSendOtpAPI(phone: String) {
        let request = SendOTPRequest(phone: phone)
        let endpoint = Endpoint(path: .loginSendOTP,method: .post,body: try? JSONEncoder().encode(request))
        self.performRequest(endpoint: endpoint) { (response:SignInResponse) in
            if response.status == true{
                
            }
            else{
                self.onError?(response.message ?? "")
            }
        }
    }
    
    //MARK: Send OTP API
    func loginVerifyOtpAPI(phone: String) {
        let request = SendOTPRequest(phone: phone,)
        let endpoint = Endpoint(path: .loginSendOTP, method: .post, body: try? JSONEncoder().encode(request))

        self.performRequest(endpoint: endpoint) { (response:SignInResponse) in
            if response.status == true{
                self.onVerifySuccess?()
            }
            else{
                self.onError?(response.message ?? "")
            }
        }
    }
}
