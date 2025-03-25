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
    
    var details: (name: String, imageResource: ImageResource, screen: AnyView,destination:Destination) {
        switch self {
        case .home:
            return (name: id, imageResource: .homeIcon, screen: AnyView(LazyView(HomeScreen())),destination:.home)
        case .shop:
            return (name: id, imageResource: .shopIcon, screen: AnyView(LazyView(ShopScreen())),destination:.shop)
        case .discounts:
            return (name: id, imageResource: .discountIcon, screen: AnyView(LazyView(DiscountsScreen())),destination:.discounts)
        case .gallery:
            return (name: id, imageResource: .galleryIcon, screen: AnyView(LazyView(GalleryScreen())),destination:.gallery)
        case .profile:
            return (name: id, imageResource: .profileIcon, screen: AnyView(LazyView(ProfileScreen())),destination:.profile)
        }
    }
}
