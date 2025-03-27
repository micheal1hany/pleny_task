//
//  PostRequestModel.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//

import Foundation

struct PostsRequestModel:NetworkRequest{
    
    var skip:Int?
    
    var path: Endpoints{
        .getPosts
    }
    
    var headers: [String : String]?
    
    var queryItems: [URLQueryItem]?{
        [URLQueryItem(name: "limit", value: "10"),URLQueryItem(name: "skip", value: String(skip ?? 0))]
    }
    
    var body: [String : Any]?
    
    var method: HTTPMethods{
        .GET
    }
    
    
}
