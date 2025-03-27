//
//  PostsRequestModel 2.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//


import Foundation

struct SearchPostsRequestModel:NetworkRequest{
    
    var skip:Int?
    var searchValue:String?
    
    var path: Endpoints{
        .searchPosts
    }
    
    var headers: [String : String]?
    
    var queryItems: [URLQueryItem]?{
        [URLQueryItem(name: "limit", value: "10"),URLQueryItem(name: "skip", value: String(skip ?? 0)),URLQueryItem(name: "q", value: searchValue)]
    }
    
    var body: [String : Any]?
    
    var method: HTTPMethods{
        .GET
    }
    
    
}
