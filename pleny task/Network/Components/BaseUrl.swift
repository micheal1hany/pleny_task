//
//  BaseUrl.swift
//  LoyaltySDK
//
//  Created by Micheal Hany on 11/09/2024.
//

import Foundation


enum BaseUrl:String{
    case baseURLDummy

    func getURL()->String{
        switch self {
        case .baseURLDummy:
            return "dummyjson.com"
        }
    }
    
    
}
