//
//  AuthModel.swift
//  FYEO
//
//  Created by Harvi Jivani on 12/03/26.
//

import Foundation

//MARK: - Authentication Module API's

//MARK: - Register Flow
struct RegisterRequest:Encodable{
    let name:String
    let phone:String
    let email:String?
    let password:String?
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case phone = "phone"
        case email = "email"
        case password = "password"
    }
}

struct RegisterResponse:Decodable{
    let status:Bool?
    let message:String?
}

//MARK: - Sign In Flow
struct SignInRequest: Encodable {
    let phone: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case phone = "phone"
        case password = "password"
    }
}

struct SignInResponse: Decodable{
    let status:Bool?
    let message:String?
    let token: String?
    let userId: Int?
    let name: String?
}

struct SendOTPRequest:Encodable{
    let phone:String
}

struct VerifyAuthRequest:Encodable{
    let phone:String
    let otp:String?
}

//MARK: - Connect User Flow
struct SuggestedUser{
    let id:Int
    let userName:String
    let displayName:String
    let imageUrl:String
    var isFollowed:Bool
}
