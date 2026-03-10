//
//  APIRouter.swift
//  FYEO
//
//  Created by Harvi Jivani on 07/03/26.
//

import Foundation

//Defines API routes

enum APIRouter {
    //Health
    case health
    
    //Auth
    case register(name: String, phone: String, email: String, password:String)
    case verifyRegistration(phone: String, otp: String)
    case loginWithPassword(phone: String, password: String)
    case loginSendOTP(phone: String)
    case loginVerifyOTP(phone: String, otp: String)
    case forgotPassword(phone: String)
    
    case resetPassword(phone: String, otp: String, newPassword: String)
}

extension APIRouter {
    
    //MARK: - Base URL
    var baseURL: String {
        return "https://alb-wise-1642391249.us-east-1.elb.amazonaws.com/api/v1"
    }
    
    //MARK: - End Points
    var path: String {
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
    
    //MARK: - HTTP methods
    var method: HTTPMethod {
        switch self {
            
        case .health:
            return .get
            
        case .register:
            return .post
            
        case .verifyRegistration:
            return .post
            
        case .loginWithPassword:
            return .post
            
        case .loginSendOTP:
            return .post
            
        case .loginVerifyOTP:
            return .post
            
        case .forgotPassword:
            return .post
            
        case .resetPassword:
            return .post
            
        }
    }
    
    //MARK: - Request Parameters
    var parameters: [String: Any]? {
        
        switch self {
            
        case .health:
            return nil
            
        case .register(let name, let phone, let email, let password):
            return [
                "name":name,
                "phone":phone,
                "email":email,
                "password":password
            ]
            
        case .verifyRegistration(let phone, let otp):
            return [
                "phone":phone,
                "otp":otp,
            ]
            
        case .loginWithPassword(let phone, let password):
            return [
                "phone": phone,
                "password": password
            ]
            
        case .loginSendOTP(let phone):
            return [
                "phone": phone,
            ]
            
        case .loginVerifyOTP(let phone, let otp):
            return [
                "phone":phone,
                "otp":otp,
            ]
            
        case .forgotPassword(let phone):
            return [
                "phone": phone,
            ]
            
        case .resetPassword(let phone, let otp, let newPassword):
            return [
                "phone":phone,
                "otp":otp,
                "new_password":newPassword
            ]
        }
    }
    
}
