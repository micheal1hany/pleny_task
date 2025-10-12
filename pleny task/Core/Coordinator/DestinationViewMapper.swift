//
//  DestinationViewMapper.swift
//  pleny task
//
//  Created by Micheal Hany on 12/05/2025.
//

import SwiftUI

@ViewBuilder func buildView(for destination: PushDestination) -> some View {
    
    switch destination {
    case .main:
        MainScreen()
    case .home:
        HomeScreen()
    case .shop:
        ShopScreen()
    case .discounts:
        DiscountsScreen()
    case .gallery:
        GalleryScreen()
    case .profile:
        ProfileScreen()
    case .login:
        LoginScreen()
    }
}

@ViewBuilder func buildView(for destination: TabDestination) -> some View {
    
    switch destination {
    case .home:
        HomeScreen()
    case .shop:
        ShopScreen()
    case .discounts:
        DiscountsScreen()
    case .gallery:
        GalleryScreen()
    case .profile:
        ProfileScreen()
    }
}

@ViewBuilder func buildView(for destination: FullScreenDestination) -> some View {
    
    Group{
        switch destination {
        case .main:
            MainScreen()
        case .home:
            HomeScreen()
        case .shop:
            ShopScreen()
        case .discounts:
            DiscountsScreen()
        case .gallery:
            GalleryScreen()
        case .profile:
            ProfileScreen()
        case .login:
            LoginScreen()
        }
    }
    // add whatever modifiers that your view needs
}


@ViewBuilder func buildView(for destination: SheetDestination) -> some View {
    
    Group{
        switch destination {
        case .main:
            MainScreen()
        case .home:
            HomeScreen()
        case .shop:
            ShopScreen()
        case .discounts:
            DiscountsScreen()
        case .gallery:
            GalleryScreen()
        case .profile:
            ProfileScreen()
        case .login:
            LoginScreen()
        }
    }
    // add whatever modifiers that your view needs
}
