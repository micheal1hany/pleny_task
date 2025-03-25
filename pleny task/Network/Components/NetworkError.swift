//
//  NetworkError.swift
//  LoyaltySDK
//
//  Created by Micheal Hany on 11/09/2024.
//

import Foundation

protocol APIErrorModel:Codable{
    var errorMessage:String? { get set }
    var errorCode:String? { get set }
    var statusCode:String? { get set }
}

struct APIError:Error{
    
    enum NetworkError:Error,Equatable{
        static func == (lhs: APIError.NetworkError, rhs: APIError.NetworkError) -> Bool {
                    switch (lhs, rhs) {
                    case (.noData, .noData),
                         (.noInternetConnection, .noInternetConnection),
                         (.encodeError, .encodeError),
                         (.unauthorized, .unauthorized),
                         (.urlError, .urlError),
                         (.unknownApiError, .unknownApiError):
                        return true
                        
                    case (.apiError(let lhsModel), .apiError(let rhsModel)):
                        return lhsModel.errorMessage == rhsModel.errorMessage &&
                               lhsModel.errorCode == rhsModel.errorCode &&
                               lhsModel.statusCode == rhsModel.statusCode
                        
                    default:
                        return false
                    }
                }
        
        case noData
        case noInternetConnection
        case encodeError
        case unauthorized
        case badRequest
        case apiError(erroModel:APIErrorModel)
        case urlError
        case unknownApiError
        
        var errorDescription: String {
            switch self {
            case .noData:
                return "No Data Returned"
            case .noInternetConnection:
                return "No internet connection"
            case .encodeError:
                return "Invalid HTTP response/or encoding error"
            case .unauthorized:
                return "Unauthorized"
            case .apiError(erroModel: let model):
                return String(describing: model)
            case .urlError:
                return "Invalid URL"
            case .unknownApiError:
                return "Something went wrong!"
            case .badRequest:
                return "Bad Request or invalid data"
            }
            
        }
        
    }
    
    let error:NetworkError
    let statusCode:Int
    let message:String
    
    init(error: NetworkError, statusCode: Int = 0, message: String = "") {
        self.error = error
        self.statusCode = statusCode
        self.message = message
    }
}


struct APIErroModelResponse:APIErrorModel{
    var errorMessage: String?
    
    var errorCode: String?
    
    var statusCode: String?
    
    var title:String?
    
    var message:String?
    
    enum CodingKeys: String, CodingKey {
        case errorMessage = "errorMessage"
        case errorCode = "errorCode"
        case statusCode = "statusCode"
        case title = "title"
        case message = "message"
    }
}

