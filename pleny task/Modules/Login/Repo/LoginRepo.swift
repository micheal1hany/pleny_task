//
// 
//  LoginRepo.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI
import Foundation

class LoginRepo{
    
    func login(username:String,password:String) async throws -> LoginResponse? {
        do {
            let result = try await API.shared.asyncRequest(request: LoginRequestModel(username: username, password: password), model: LoginResponse.self)
            return result
        }catch let error as APIError{
            Log.e(error.message)
            throw error
        }catch{
            Log.e(error.localizedDescription)
            throw error
        }
    }
    
}
