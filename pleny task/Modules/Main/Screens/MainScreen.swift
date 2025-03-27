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
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            ForEach(AppTabs.allCases) { tab in
                tab.details.tabScreen
                    .tabItem {
                        Label(LocalizedStringKey(tab.details.name), image: tab.details.imageResource)
                            .onTapGesture {
                                coordinator.selectTab(tab)
                            }
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
