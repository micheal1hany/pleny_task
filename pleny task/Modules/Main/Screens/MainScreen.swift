//
//
//  MainScreen.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI

struct MainScreen: View {
    
    @StateObject private var vm = MainViewModel()
    
//    @State var coordinator = Coordinator(rootView: .main, level: 0, identifierTab: nil)
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
//        TabView(selection: $coordinator.selectedTab){
//            CoordinatorView(parentCoordinator: coordinator,tab: .home) {
//                HomeScreen()
//            }
//            .tabItem {
//                Label(LocalizedStringKey(TabDestination.home.item.name), image: TabDestination.home.item.imageResource)
//            }
//            .tag(TabDestination.home)
//            
//            CoordinatorView(parentCoordinator: coordinator,tab: .shop) {
//                ShopScreen()
//            }
//            .tabItem {
//                Label(LocalizedStringKey(TabDestination.shop.item.name), image: TabDestination.shop.item.imageResource)
//            }
//            .tag(TabDestination.shop)
//            
//            
//            CoordinatorView(parentCoordinator: coordinator,tab: .discounts) {
//                DiscountsScreen()
//            }
//            .tabItem {
//                Label(LocalizedStringKey(TabDestination.discounts.item.name), image: TabDestination.discounts.item.imageResource)
//            }
//            .tag(TabDestination.discounts)
//            
//            
//            CoordinatorView(parentCoordinator: coordinator,tab: .gallery) {
//                GalleryScreen()
//            }
//            .tabItem {
//                Label(LocalizedStringKey(TabDestination.gallery.item.name), image: TabDestination.gallery.item.imageResource)
//            }
//            .tag(TabDestination.gallery)
//            
//            
//            CoordinatorView(parentCoordinator: coordinator,tab: .profile) {
//                ProfileScreen()
//            }
//            .tabItem {
//                Label(LocalizedStringKey(TabDestination.profile.item.name), image: TabDestination.profile.item.imageResource)
//            }
//            .tag(TabDestination.profile)
//            
//        }
        TabView(selection: $coordinator.selectedTab) {
            ForEach(TabDestination.allCases,id: \.id) { tab in
                CoordinatorView(parentCoordinator: coordinator, tab: tab, content: {
                    buildView(for: tab)
                })
                .tabItem {
                    Label(LocalizedStringKey(tab.item.name), image: tab.item.imageResource)
                }
                .tag(tab)
            }
        }
        .onChange(of: coordinator.selectedTab, perform: { newValue in
            print("value: \(newValue)")
        })
        .accentColor(Color(hex: AppColors.mainColor))
    }
}

#Preview {
    MainScreen()
}
