//
//  Endpoint.swift
//  FYEO
//
//  Created by Harvi Jivani on 07/03/26.
//

import Foundation

//Defines API routes

struct Endpoint{
    
    let version = "v1"
    
    var baseURL: String {
        return "https://alb-wise-1642391249.us-east-1.elb.amazonaws.com/api/"
    }
    
    let path: APIRoute
    let method: HTTPMethod
    let body: Data?
    
    var urlString: String {
        return "\(baseURL)\(version)\(path.route)"
    }
}

