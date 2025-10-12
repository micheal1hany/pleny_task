//
//  CoordinatorView.swift
//  WafaTel
//
//  Created by Micheal Hany on 03-07-2024.
//

import SwiftUI


/// ``NavigationStack`` container that works with the ``Coordinator``
/// to resolve the routes based on the ``Coordinator``'s state
struct CoordinatorView<Content: View>: View  {
    // The coordinator view itself it's in charge of the lifecycle
    // of the coordinator.
    @ObservedObject var coordinator: Coordinator
    @ViewBuilder var content: () -> Content
    
    init(parentCoordinator: Coordinator,isRoot:Bool = false, tab: TabDestination? = nil, @ViewBuilder content: @escaping () -> Content) {
        self._coordinator = .init(initialValue: isRoot ? parentCoordinator : parentCoordinator.childCoordinator(for: tab))
        self.content = content
    }
    
  
    var body: some View {
        InnerContainer(coordinator: coordinator) {
            content()
        }
        .environmentObject(coordinator)
        .onAppear(perform: coordinator.setActive)
        .modifier(ZoomTransitionModifier(isAnimating: $coordinator.isReplace))
        .onDisappear(perform: coordinator.resignActive)
//        .onOpenURL(perform: openDeepLinkIfFound(for:))
        
    }
#warning("Please adapt deep linking later")
//    func openDeepLinkIfFound(for url: URL) {
//        if let destination = DeepLink.destination(from: url) {
//            router.deepLinkOpen(to: destination)
//        } else {
//            router.logger.warning("No destination matches \(url)")
//        }
//    }
}

// This is necessary for getting a binder from an Environment Observable object
private struct InnerContainer<Content: View>: View {
    @ObservedObject var coordinator: Coordinator
    @ViewBuilder var content: () -> Content

    var body: some View {
        NavigationStack(path: $coordinator.navigationStackPath) {
            content()
                .navigationDestination(for: PushDestination.self) { destination in
                    buildView(for: destination)
                        .navigationBarBackButtonHidden()
                }
        }
        // it's important that the these modifiers are **outside** the `NavigationStack`
        // otherwise the content closure will be called infinitely freezing the app
        .sheet(item: $coordinator.sheet) { sheet in
            navigationView(for: sheet, from: coordinator)
        }
        .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreen in
            navigationView(for: fullScreen, from: coordinator)
        }
    }

    @ViewBuilder func navigationView(for destination: SheetDestination, from coordinator: Coordinator) -> some View {
        CoordinatorView(parentCoordinator: coordinator) { buildView(for: destination) }
    }


    @ViewBuilder func navigationView(for destination: FullScreenDestination, from coordinator: Coordinator) -> some View {
        CoordinatorView(parentCoordinator: coordinator) { buildView(for: destination) }
    }
}
