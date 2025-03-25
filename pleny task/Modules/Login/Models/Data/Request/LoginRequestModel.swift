//
//  LoginRequestModel.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//

import Foundation


struct LoginRequestModel:NetworkRequest{
    
    var username:String
    var password:String
    
    var path: Endpoints{
        .login
    }
    
    var method: HTTPMethods{
        .POST
    }
    
    var authorizedRequest: Bool{
        false
    }
    
    var headers: [String : String]?
    
    var queryItems: [URLQueryItem]?
    
    var body: [String : Any]?{
        ["username":username,"password":password]
    }
    
    
    
    
}
