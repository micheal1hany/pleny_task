//
//  RootContainer.swift
//  pleny task
//
//  Created by Micheal Hany on 12/05/2025.
//

import SwiftUI

struct RootContainer: View {
    @StateObject var coordinator = Coordinator(rootView: .login, level: 0, identifierTab: nil)
    
    var body: some View {
        CoordinatorView(parentCoordinator: coordinator,isRoot: true, tab: nil) {
            buildView(for: coordinator.rootView)
        }
//        if coordinator.selectedTab == nil {
//            CoordinatorView(parentCoordinator: coordinator,isRoot: true, tab: nil) {
//                buildView(for: coordinator.rootView)
//            }
//        }else{
//            buildView(for: coordinator.rootView)
//                .environmentObject(coordinator)
//        }
        
        
    }
}
