//
//  APIRoute.swift
//  FYEO
//
//  Created by Harvi Jivani on 12/03/26.
//

import Foundation

enum APIRoute{
    //Health
    case health
    
    //Auth
    case register
    case verifyRegistration
    case loginWithPassword
    case loginSendOTP
    case loginVerifyOTP
    case forgotPassword
    case resetPassword
}

extension APIRoute {
    //MARK: - End Points
    var route: String {
        switch self {
        case .health:
            return "/health"
            
        case .register:
            return "/auth/register"
            
        case .verifyRegistration:
            return "/auth/verify-registration"
            
        case .loginWithPassword:
            return "/auth/login/password"
            
        case .loginSendOTP:
            return "/auth/login/send-otp"
            
        case .loginVerifyOTP:
            return "/auth/login/verify-otp"
            
        case .forgotPassword:
            return "/auth/forgot-password"
            
        case .resetPassword:
            return "/auth/reset-password"
        }
    }
}
