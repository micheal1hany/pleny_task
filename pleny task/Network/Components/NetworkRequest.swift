//
//  NetworkRequest.swift
//  LoyaltySDK
//
//  Created by Micheal Hany on 11/09/2024.
//

import Foundation

protocol NetworkRequest{
    var baseURL: String { get }
    var path: Endpoints { get }
    var method: HTTPMethods { get }
    var headers: [String:String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
    var authorizedRequest : Bool {get}
}

extension NetworkRequest{
    
    var baseURL: String {
        return BaseUrl.baseURLDummy.getURL()
    }
    
    var authorizedRequest : Bool {
        return true
    }
    var method:HTTPMethods{
        return .GET
    }
    
    func asURLRequest() async throws -> URLRequest {
        var urlComponents = URLComponents() // 5
        urlComponents.scheme = "https"
        urlComponents.host =  baseURL
        urlComponents.path = path.rawValue
        
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            throw APIError(error: .urlError, statusCode: 0, message: "Url Error")
        }
        
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(HTTPHeaders.applicationJson.rawValue,
                            forHTTPHeaderField: HTTPHeaders.accept.rawValue)
        urlRequest.addValue(HTTPHeaders.applicationJson.rawValue,
                            forHTTPHeaderField:HTTPHeaders.contentType.rawValue)
        
        urlRequest.addValue("en",
                            forHTTPHeaderField:HTTPHeaders.acceptLanguage.rawValue)
        
        if await API.shared.token?.isEmpty == false && authorizedRequest == true {
            urlRequest.addValue("Bearer \(await API.shared.token ?? "")", forHTTPHeaderField: HTTPHeaders.auth.rawValue)
        }
        
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw APIError(error: .encodeError, message: "Error encoding http body")
            }
        }
        return urlRequest
    }
}
