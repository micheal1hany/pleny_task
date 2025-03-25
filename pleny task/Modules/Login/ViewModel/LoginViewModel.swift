//
//
//  LoginViewModel.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI
import Combine


class LoginViewModel: BaseViewModel {
    
    
    private var repo = LoginRepo()
    
    @Published var user:LoginResponse? = nil
    
    @Published var isFormValid: Bool = false
    
    @Published var userNameError: String? = ""
    @Published var passwordError: String? = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func onStart(){
        startValidationPublisher()
    }
    
    func startValidationPublisher() {
        Publishers.CombineLatest($userNameError, $passwordError)
            .map { userNameError, passwordError in
                return TextFieldValidator.isFormValid(fieldsErrors: [userNameError,passwordError])
            }
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: &$isFormValid)
        
            
    }
    
    @MainActor var loginError: APIError? {
        if case let .failed(error) = self.state {
            return error as? APIError
        }
        return nil
    }
    
    // MARK: login
    @MainActor func login(username:String,password:String) async {
        
        state = .loading
        
        do{
            if let data = try await repo.login(username: username, password: password) {
                self.user = data
                if let token = data.accessToken{
                    await API.shared.setToken(token: token)
                }
                self.state = .success
            }else{
                state = .empty
            }
        }catch let error as APIError {
            Log.e(error)
            if error.error == .noInternetConnection {
                self.state = .noInternet
            }else{
                self.state = .failed(error)
            }
        }catch{
            Log.e(error)
            self.state = .failed(error)
        }
        
    }
    
}
