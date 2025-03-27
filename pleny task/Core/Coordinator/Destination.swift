//
//  Destination.swift
//  CoordinatorDemo
//
//  Created by Micheal Hany on 25/12/2024.
//

import Foundation
import SwiftUI

enum Destination: String, Identifiable {
    case main,
         home,
         shop,
         discounts,
         gallery,
         profile,
         login
    
    
    var id: String {
        self.rawValue
    }
}

enum AppTabs: String, CaseIterable,Identifiable {
    case home = "Home"
    case shop = "Shop"
    case discounts = "Discounts"
    case gallery = "Gallery"
    case profile = "Profile"
    
    var id: String {
        self.rawValue
    }
    
    var item: (name: String, imageResource: String, tabScreen: Destination) {
        switch self {
        case .home:
            return (name: id, imageResource: "home_icon", tabScreen: .home)
        case .shop:
            return (name: id, imageResource: "shop_icon", tabScreen: .shop)
        case .discounts:
            return (name: id, imageResource: "discount_icon", tabScreen: .discounts)
        case .gallery:
            return (name: id, imageResource: "gallery_icon", tabScreen: .gallery)
        case .profile:
            return (name: id, imageResource: "profile_icon", tabScreen: .profile)
        }
    }
}
