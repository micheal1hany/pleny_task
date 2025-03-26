//
//  PostResponseModel.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//


import Foundation

// MARK: - PostResponseModel
struct PostResponseModel: Codable {
    let posts: [Post]?
    let total: Int?
    let skip: Int?
    let limit: Int?

    enum CodingKeys: String, CodingKey {
        case posts = "posts"
        case total = "total"
        case skip = "skip"
        case limit = "limit"
    }
}

// MARK: - Post
struct Post: Codable,Identifiable {
    let uuid = UUID()
    let id: Int?
    let title: String?
    let body: String?
    let tags: [String]?
    let reactions: Reactions?
    let views: Int?
    let userID: Int?
    let postDate: Int?
    let userName: String?
    let userImage: String?
    let postImages: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case body
        case tags
        case reactions
        case views
        case userID
        case postDate
        case userName
        case userImage
        case postImages
    }
}

// MARK: - Reactions
struct Reactions: Codable {
    let likes: Int?
    let dislikes: Int?

    enum CodingKeys: String, CodingKey {
        case likes = "likes"
        case dislikes = "dislikes"
    }
}
