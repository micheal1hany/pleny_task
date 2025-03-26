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
    
    var details: (name: String, imageResource: String, tabScreen: AnyView) {
        switch self {
        case .home:
            return (name: id, imageResource: "home_icon", tabScreen: AnyView(LazyView(HomeScreen())))
        case .shop:
            return (name: id, imageResource: "shop_icon", tabScreen: AnyView(LazyView(ShopScreen())))
        case .discounts:
            return (name: id, imageResource: "discount_icon", tabScreen: AnyView(LazyView(DiscountsScreen())))
        case .gallery:
            return (name: id, imageResource: "gallery_icon", tabScreen: AnyView(LazyView(GalleryScreen())))
        case .profile:
            return (name: id, imageResource: "profile_icon", tabScreen: AnyView(LazyView(ProfileScreen())))
        }
    }
}
