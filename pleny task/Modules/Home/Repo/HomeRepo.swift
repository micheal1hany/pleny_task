//
// 
//  HomeRepo.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI
import Foundation

class HomeRepo{
    
    func getPosts(skip:Int) async throws -> [PostUIModel]? {
        do {
            let result = try await API.shared.asyncRequest(request: PostsRequestModel(skip:skip), model: PostResponseModel.self)
            return result.posts?.map { post in
                PostUIModel(res: Post(
                    id: post.id,
                    title: post.title,
                    body: post.body,
                    tags: post.tags,
                    reactions: post.reactions,
                    views: post.views,
                    userID: post.userID,
                    postDate: post.postDate ?? Int.random(in: 1...25),
                    userName: post.userName ?? getRandomUserName(), // Inject random name if nil
                    userImage: post.userImage ?? getRandomUserImage(), // Inject random image if nil
                    postImages: post.postImages ?? getRandomPostPhotos() // Inject random post images if nil
                ))
            }
        }catch let error as APIError{
            Log.e(error.message)
            throw error
        }catch{
            Log.e(error.localizedDescription)
            throw error
        }
    }
    
    func searchPosts(skip:Int,searchValue:String) async throws -> [PostUIModel]? {
        do {
            let result = try await API.shared.asyncRequest(request: SearchPostsRequestModel(skip:skip, searchValue: searchValue), model: PostResponseModel.self)
            return result.posts?.map { post in
                PostUIModel(res: Post(
                    id: post.id,
                    title: post.title,
                    body: post.body,
                    tags: post.tags,
                    reactions: post.reactions,
                    views: post.views,
                    userID: post.userID,
                    postDate: post.postDate ?? Int.random(in: 1...25),
                    userName: post.userName ?? getRandomUserName(), // Inject random name if nil
                    userImage: post.userImage ?? getRandomUserImage(), // Inject random image if nil
                    postImages: post.postImages ?? getRandomPostPhotos() // Inject random post images if nil
                ))
            }
        }catch let error as APIError{
            Log.e(error.message)
            throw error
        }catch{
            Log.e(error.localizedDescription)
            throw error
        }
    }
    
    
    
    func getRandomPostPhotos() -> [String]? {
        let allImages: [String] = [
            "post_1", "post_2", "post_3", "post_4", "post_5",
            "post_6", "post_7", "post_8", "post_9"
        ]
        
        // Generate a random number between 1 and the total number of images
        let randomCount = Int.random(in: 1...allImages.count)
        
        // Shuffle the array and pick a random subset
        return Array(allImages.shuffled().prefix(randomCount))
    }
    
    func getRandomUserName() -> String? {
        return ["Micheal Hany","Peter Bassem", "Youssef Khalid","Rana Hisham"].randomElement()
    }
    
    func getRandomUserImage() -> String? {
        return ["up1","up2","up3"].randomElement()
    }
    
    
    
}
