//
//  LoginResponse.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//


import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let id: Int?
    let username: String?
    let email: String?
    let firstName: String?
    let lastName: String?
    let gender: String?
    let image: String?
    let accessToken: String?
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
        case gender = "gender"
        case image = "image"
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
