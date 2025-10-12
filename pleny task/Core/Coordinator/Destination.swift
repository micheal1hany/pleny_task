//
//  Destination.swift
//  CoordinatorDemo
//
//  Created by Micheal Hany on 25/12/2024.
//

import Foundation
import SwiftUI


// MARK: NavigationType Enum
enum NavigationType: Hashable {
    case tab(_ destination:TabDestination)
    case fullScreenCover(_ destination:FullScreenDestination)
    case push(_ destination:PushDestination)
    case sheet(_ destination:SheetDestination)
    
    
    var description: String {
        switch self {
        case let .tab(destination): ".tab(\(destination))"
        case let .push(destination): ".push(\(destination))"
        case let .sheet(destination): ".sheet(\(destination))"
        case let .fullScreenCover(destination): ".fullScreen(\(destination))"
        }
    }
}



// MARK: Push Destinations Enum
enum PushDestination: String, Identifiable {
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

// MARK: Full Screen Destinations Enum
enum FullScreenDestination: String, Identifiable {
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

// MARK: Sheets Destinations Enum
enum SheetDestination: String, Identifiable {
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


// MARK: App Navigation Bar Tabs Enum
enum TabDestination: String, CaseIterable,Identifiable {
    case home = "Home"
    case shop = "Shop"
    case discounts = "Discounts"
    case gallery = "Gallery"
    case profile = "Profile"
    
    var id: String {
        self.rawValue
    }
    
    var item: (name: String, imageResource: String, tabScreen: TabDestination) {
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
