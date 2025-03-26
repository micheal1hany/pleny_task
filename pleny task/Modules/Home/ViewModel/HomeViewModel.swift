//
// 
//  HomeViewModel.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI

class HomeViewModel: BaseViewModel {
    
    
    private var repo = HomeRepo()
    
    @MainActor @Published var posts:[PostUIModel]? = []
    
    func onStart() async{
        await getPosts(skip: 0)
    }
    
    
    // MARK: getPosts
    func getPosts(skip:Int) async {
        
        await MainActor.run {
            state = .loading
        }
        
        do{
            if let data = try await repo.getPosts(skip: skip){
                await MainActor.run {
                    if data.isEmpty {
                        state = .empty
                    }
                    self.posts = data
                    self.state = .success
                }
            }
        }catch let error as APIError {
            await MainActor.run {
                Log.e(error)
                if error.error == .noInternetConnection {
                    self.state = .noInternet
                }else{
                    self.state = .failed(error)
                }
            }
        }catch{
            await MainActor.run {
                Log.e(error)
                self.state = .failed(error)
            }
        }
        
    }
    
    
}
