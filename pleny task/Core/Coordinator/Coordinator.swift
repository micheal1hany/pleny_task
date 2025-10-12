//
//  Coordinator.swift
//  CoordinatorDemo
//
//  Created by Micheal Hany on 25/12/2024.
//


import SwiftUI
internal import OSLog

final class Coordinator: ObservableObject {
    
    let id = UUID()
    var level: Int
    
    /// Reference to the parent coordinator to form a hierarchy
    /// Coordinator levels increase for the children
    weak var parent: Coordinator?
    
    /// Specifies which tab the coordinator was build for
    var identifierTab: TabDestination?
    
    /// Only relevant for the `level 0` root coordinator. Defines the tab to select
    @Published var selectedTab: TabDestination?
    
    /// Values presented in the navigation stack
    @Published var navigationStackPath: [PushDestination] = []
    
    /// Current presented sheet
    @Published var sheet: SheetDestination?
    
    /// Current presented full screen
    @Published var fullScreenCover: FullScreenDestination?
    
    
    @Published var isReplace: Bool = false
    
    
    @Published var rootView: PushDestination
    
    /// current navigation type
    var navigationType: NavigationType?
    
    /// passed arguments to current destination
    var arguments: Any?
    
    /// A way to track which coordinator is visible/active
    /// Used for deep link resolution
    private(set) var isActive: Bool = false
    
    
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "Navigation")
    
    
    init(rootView:PushDestination, level: Int, identifierTab: TabDestination?) {
        self.level = level
        self.identifierTab = identifierTab
        self.parent = nil
        self.rootView = rootView

        logger.debug("\(self.debugDescription) initialized")
    }
    
    deinit {
        logger.debug("\(self.debugDescription) deinit")
    }
    
    private func resetContent() {
        navigationStackPath = []
        sheet = nil
        fullScreenCover = nil
    }
}

// MARK: - Coordinator Management

extension Coordinator {
    func childCoordinator(for tab: TabDestination? = nil) -> Coordinator {
        let coordinator = Coordinator(rootView: parent?.rootView ?? rootView, level: level + 1, identifierTab: tab ?? identifierTab)
        coordinator.parent = self
        coordinator.navigationType = navigationType
        return coordinator
    }

    func setActive() {
        logger.debug("\(self.debugDescription): \(#function)")
        parent?.resignActive()
        isActive = true
    }

    func resignActive() {
        logger.debug("\(self.debugDescription): \(#function)")
        isActive = false
    }

}

// MARK: - Navigation

extension Coordinator {
    func navigate(to destination: NavigationType) {
        
        navigationType = destination
        
        switch destination {
        case let .tab(tab):
            select(tab: tab)

        case let .push(destination):
            push(destination)

        case let .sheet(destination):
            present(sheet: destination)

        case let .fullScreenCover(destination):
            present(fullScreen: destination)
        }
    }
    
    func pop(){
        logger.debug("\(self.debugDescription) \(#function)")
        switch navigationType{
        case .push:
            navigationStackPath.removeLast()
        case .sheet:
            parent?.sheet = nil
        case .fullScreenCover:
            parent?.fullScreenCover = nil
        default:
            break
        }
    }
    
    func popToRoot() {
        logger.debug("\(self.debugDescription) \(#function)")
        resetContent()
        arguments = nil
    }
    
    func replace(with destination:PushDestination, arguments: Any? = nil){
        logger.debug("\(self.debugDescription) \(#function)")
        
        isReplace = true
        
        if let args = arguments {
            self.arguments = args
        }
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else {return}
            
            withAnimation {
                if !self.navigationStackPath.isEmpty && self.navigationStackPath.last != destination{
                    self.pop()
                    self.navigationStackPath.append(destination)
                }
                self.isReplace = false
            }
        }
    }
    
    func replaceRoot(with destination:PushDestination, tab:TabDestination? = nil){
        logger.debug("\(self.debugDescription) \(#function)")
        
        isReplace = true
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            withAnimation {
                self.parent?.resetContent()
                self.resetContent()
                self.level = 0
                self.identifierTab = tab
                self.rootView = destination
                self.isReplace = false
            }
        }
    }

    func select(tab destination: TabDestination) {
        logger.debug("\(self.debugDescription) \(#function) \(destination.rawValue)")
        
        if level == 0 {
            selectedTab = destination
        } else {
            parent?.select(tab: destination)
            resetContent()
        }
    }

    func push(_ destination: PushDestination) {
        logger.debug("\(self.debugDescription): \(#function) \(destination.rawValue)")
        navigationStackPath.append(destination)
    }

    func present(sheet destination: SheetDestination) {
        logger.debug("\(self.debugDescription): \(#function) \(destination.rawValue)")
        sheet = destination
    }

    func present(fullScreen destination: FullScreenDestination) {
        logger.debug("\(self.debugDescription): \(#function) \(destination.rawValue)")
        fullScreenCover = destination
    }

    func deepLinkOpen(to destination: NavigationType) {
        guard isActive else { return }

        logger.debug("\(self.debugDescription): \(#function) \(destination.description)")
        navigate(to: destination)
    }
}




// MARK: Coordinator Logging Configs
extension Coordinator: CustomDebugStringConvertible {
    var debugDescription: String {
        "Coordinator[\(shortId) - \(identifierTabName) - Level: \(level)]"
    }

    private var shortId: String { String(id.uuidString.split(separator: "-").first ?? "") }

    private var identifierTabName: String {
        identifierTab?.rawValue ?? "No Tab"
    }
}
