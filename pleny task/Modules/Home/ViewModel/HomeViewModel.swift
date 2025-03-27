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
    
    @Published var posts:[PostUIModel]? = []
    
    var totalItems:Int = 0
    var skip:Int = 0
    var lastPage:Bool = false
    
//    func onStart() async{
//        await getPosts(skip: 0)
//    }
    
    
    //MARK: - PAGINATION
    func loadNextPostsPage(currentItem item: PostUIModel,searchValue:String? = nil) async {
        if self.posts?.last?.id == item.id && !self.lastPage{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.skip += 10
                Task{
                    await self.getPosts(skip: self.skip,paginating:true, searchValue: searchValue)
                }
            }
        }
    }
    
    // MARK: getPosts
    func getPosts(skip:Int,paginating:Bool = false,searchValue:String? = nil) async {
        if paginating {
            await MainActor.run {
                paginationState = .nextPage
            }
        }else{
            await MainActor.run {
                self.posts = []
                self.skip = 0
                state = .loading
            }
        }
        
        if let searchValue = searchValue , !searchValue.isEmpty{
            await searchPost(skip: skip, searchValue: searchValue)
            return
        }
        
        await getPostsFeed(skip: skip)
        
        
        
    }
    
    // MARK: searchPost
    private func searchPost(skip:Int,paginating:Bool = false,searchValue:String) async {
        
        do{
            if let data = try await repo.searchPosts(skip: skip, searchValue: searchValue){
                await MainActor.run {
                    if data.isEmpty && self.skip == 0 {
                        self.state = .empty
                        return
                    }else if data.isEmpty {
                        self.lastPage = true
                        self.paginationState = .none
                        return
                    }
                    self.posts?.append(contentsOf: data)
                    self.state = .success
                    self.paginationState = .none
                    self.lastPage = false
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
    
    private func getPostsFeed(skip:Int)async{
        do{
            if let data = try await repo.getPosts(skip: skip){
                await MainActor.run {
                    if data.isEmpty && self.skip == 0 {
                        self.state = .empty
                        return
                    }else if data.isEmpty {
                        self.lastPage = true
                        self.paginationState = .none
                        return
                    }
                    self.posts?.append(contentsOf: data)
                    self.state = .success
                    self.paginationState = .none
                    self.lastPage = false
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
