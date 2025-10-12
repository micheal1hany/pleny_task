//
//  CoordinatorTests.swift
//  pleny task
//
//  Created by Micheal Hany on 18/05/2025.
//


import Testing
import SwiftUI
@testable import pleny_task

@Suite("Coordinator Tests")
struct CoordinatorTests {

    @Test("Creating a child coordinator")
    func creatingChildCoordinator() {
        // given
        let coordinator = Coordinator(rootView: .login, level: 0, identifierTab: nil)

        // when
        let child = coordinator.childCoordinator(for: .home)
        
        child.selectedTab = .home
        
        
        // then
        #expect(child.level == coordinator.level + 1)
        #expect(child.identifierTab == .home)
        #expect(child.selectedTab == .home)
        #expect(child.rootView == coordinator.rootView)
        #expect(child.rootView == .login)
    }

    @Test("Setting the child coordinator as active")
    func setChildCoordinatorAsActive() {
        // given
        let coordinator = Coordinator(rootView: .login, level: 0, identifierTab: nil)
        coordinator.setActive()
        let child = coordinator.childCoordinator(for: .home)

        // when
        child.setActive()

        // then
        #expect(!coordinator.isActive)
        #expect(child.isActive)
        
        child.navigate(to: .push(.gallery))
        
        #expect(coordinator.navigationStackPath.isEmpty)
        #expect(!child.navigationStackPath.isEmpty)
    }
    
//    @Test("Test coordinator as environment object ")
//    func testCoordinatorAfterInjectedInEnvironment() {
//        // given
//        let coordinator = Coordinator(rootView: .login, level: 0, identifierTab: nil)
//        coordinator.setActive()
//        
//        let child = CoordinatorView(parentCoordinator: coordinator, tab: .home) {EmptyView()}
//        
//        
//
//        // then
//        #expect(coordinator.isActive == false)
//        #expect(child.coordinator.isActive == true)
//        
//    }
//    

//    @Test("Selecting a tab reset the leaf router content")
//    func selectingATabResetTheLeafRouter() {
//        // given
//        let router = Router(level: 0, identifierTab: nil)
//        let child = router.childRouter(for: .home)
//        child.push(.movieDetails(id: .randomPreviewId()))
//
//        // when
//        child.select(tab: .home)
//
//        // then
//        #expect(router.selectedTab == .home)
//        #expect(child.navigationStackPath.isEmpty)
//    }

//    @Test("Opening a deep link doens't work on non active routers")
//    func openingADeepLinkOnNonActiveRouter() {
//        // given
//        let router = Router(level: 0, identifierTab: nil)
//        let home = router.childRouter(for: .home)
//        home.setActive()
//
//        // when
//        router.deepLinkOpen(to: .push(.actorDetails(id: .randomPreviewId())))
//
//        // then
//        #expect(router.navigationStackPath.isEmpty)
//    }

//    @Test("Opening a deep link works on an active router")
//    func openingADeepLinkOnActiveRouter() {
//        // given
//        let router = Router(level: 0, identifierTab: nil)
//        let home = router.childRouter(for: .home)
//        home.setActive()
//        let actorID = ActorID.randomPreviewId()
//
//        // when
//        home.deepLinkOpen(to: .push(.actorDetails(id: actorID)))
//
//        // then
//        #expect(home.navigationStackPath == [.actorDetails(id: actorID)])
//    }
}

