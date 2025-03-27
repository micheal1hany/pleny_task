//
//  CoordinatorView.swift
//  WafaTel
//
//  Created by Micheal Hany on 03-07-2024.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject var coordinator = Coordinator(rootView: .main)
    
    var body: some View {
        NavigationStack(path:$coordinator.navigationPath,root: {
            coordinator.build(page: coordinator.rootView)
                .navigationDestination(for: Destination.self) { screen in
                    coordinator.build(page: screen)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    if coordinator.navType == .sheet{
                        coordinator.build(page: sheet)
                    }
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                    if coordinator.navType == .fullScreenCover{
                        coordinator.build(page: fullScreenCover)
                    }
                }
        })
        .environmentObject(coordinator)
        .modifier(ZoomTransitionModifier(isAnimating: $coordinator.isReplace))
        
    }
}
