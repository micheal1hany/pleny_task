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
    
    @State private var selectedTab:AppTabs = .home
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(AppTabs.allCases) { tab in
                coordinator.build(page: tab.item.tabScreen)
                    .tabItem {
                        Label(LocalizedStringKey(tab.item.name), image: tab.item.imageResource)
                    }
                    .tag(tab)
            }
        }
        .onChange(of: selectedTab, perform: { tab in
            coordinator.selectTab(tab)
        })
        .accentColor(Color(hex: AppColors.mainColor))
    }
}

#Preview {
    MainScreen()
}
