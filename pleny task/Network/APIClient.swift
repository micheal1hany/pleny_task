//
//  APIClient.swift
//  LoyaltySDK
//
//  Created by Micheal Hany on 11/09/2024.
//

import Foundation

public actor API:GlobalActor{
    
    public static let shared = API()
    
    private init(){}
    
    var token :String? = ""
    
    private var session:URLSession{
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 60
        return URLSession(configuration: config)
    }
    
    
    func asyncRequest<T:Codable>(request:any NetworkRequest,model:T.Type) async throws -> T{
        
        let startDate = Date()
        var req: URLRequest?
        var res: (Data, URLResponse)?
        var httpResponse: HTTPURLResponse?
        var apiError: Error?
        
//        defer{
//            Log.logAPI(HTTPMethod: req?.httpMethod,baseURL: request.baseURL, endpoint: request.path.rawValue, statuesCode: httpResponse?.statusCode ?? 0, headers: req?.allHTTPHeaderFields?.description, params: req?.httpBody?.dictionary, requestTime: httpResponse?.requestDuration(from: startDate), res: res?.0.utf8String, error: apiError)
//        }
        
        do{
            
            req = try await request.asURLRequest()
            res = try await session.data(for: req!)
            httpResponse = res!.1 as? HTTPURLResponse
            
            
            return try self.handleResponse(data: res!.0, response: res!.1,request: request,model: model)
            
        }catch let error as APIError{
            apiError = error
            throw error
        }catch{
            apiError = error
            throw APIError(error: .unknownApiError,statusCode: 0,message: error.localizedDescription)
        }
        
        
        
    }
    
    
    private func handleResponse<T: Codable>(data: Data, response: URLResponse,request:any NetworkRequest,model:T.Type) throws -> T {        
        guard let res = response as? HTTPURLResponse else {
            throw APIError(
                error: .unknownApiError, statusCode: 0
            )
        }
        switch res.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode(model.self, from: data)
            } catch {
                Log.e(error)
                throw APIError(
                    error: .encodeError, statusCode: res.statusCode
                )
            }
        case 401 :
            Log.e("Unauthorized")
            throw APIError(error: .unauthorized,statusCode: res.statusCode)
        case 400:
            throw APIError(error: .badRequest,statusCode: res.statusCode)
        case 403:
            Log.e(data)
            throw APIError(error: .unknownApiError,statusCode: res.statusCode)
//            do{
//                return try JSONDecoder().decode(request.apiErrorModel as! T.Type, from: data)
//            }
        default:
            Log.e("Unknown Error")
            throw APIError(error: .unknownApiError, statusCode: res.statusCode)
        }
    }
    
    func setToken(token:String){
        self.token = token
    }
}
