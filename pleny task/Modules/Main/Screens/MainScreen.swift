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
    
    @ObservedObject private var vm = MainViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            ForEach(AppTabs.allCases) { tab in
                tab.details.screen
                    .tabItem {
                        Image(tab.details.imageResource)
                        Text(tab.details.name)
                    }
                    .tag(tab.id)
            }
        }
        .accentColor(Color(hex: AppColors.mainColor))
    }
}

#Preview {
    MainScreen()
}
