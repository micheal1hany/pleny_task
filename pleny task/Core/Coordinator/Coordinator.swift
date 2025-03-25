//
//  Coordinator.swift
//  CoordinatorDemo
//
//  Created by Micheal Hany on 25/12/2024.
//


import SwiftUI

enum NavigationType: String, Identifiable {
    case fullScreenCover, link, sheet
    
    var id: String {
        self.rawValue
    }
}


class Coordinator: ObservableObject {
    
    @Published var sheet: Destination?
    @Published var fullScreenCover: Destination?
    @Published var selectedTab: AppTabs = .home
    @Published var isReplace: Bool = false
    @Published var rootView: Destination
    @Published var navigationPath: [Destination] = []
    @Published var navType: NavigationType?
    @Published var passedArguments: [Destination: [String: Any]] = [:]
    
    init(rootView:Destination){
        self.rootView = rootView
    }
    
    func push(_ page: Destination, arguments: [String: Any]? = nil, type:NavigationType = .link, onComplete:(()->Void)? = nil) {
        navType = type
        
        // Store arguments for the destination
        if let args = arguments {
            passedArguments[page] = args
        }

        switch navType {
        case .fullScreenCover:
            self.fullScreenCover = page
        case .link:
            navigationPath.append(page)
        case .sheet:
            self.sheet = page
        default:
            break
        }
        
        onComplete?()
    }
    
    func replace(with page:Destination, arguments: [String: Any]? = nil, replaceRoot:Bool = false){
        
        isReplace = true
        
        if let args = arguments {
            passedArguments[page] = args
        }
        
        DispatchQueue.main.async {
            withAnimation {
                
                if replaceRoot{
                    self.rootView = page
                    
                }
                
                if !self.navigationPath.isEmpty && self.navigationPath.last != page{
                    self.pop()
                    self.navigationPath.append(page)
                }
                
                self.isReplace = false
            }
        }
       
        
    }
    
    func pop(to destination:Destination, inclusive:Bool = false){
        if !navigationPath.isEmpty{
            guard var foundedPath = navigationPath.firstIndex(of: destination) else { return }
            
            if !inclusive {
                foundedPath += 1
            }
                   
            let numToPop = (foundedPath..<navigationPath.endIndex).count
            navigationPath.removeLast(numToPop)
            
        }
    }
    
    func pop() {
        
        if let lastPage = navigationPath.last {
            passedArguments[lastPage] = nil // Clear arguments for the popped page
        }
        
        if (fullScreenCover == nil) && (sheet == nil){
            navType = .link
        }else if fullScreenCover != nil{
            navType = .fullScreenCover
        }else{
            navType = .sheet
        }
        
        switch self.navType {
        case .fullScreenCover:
            fullScreenCover = nil
        case .link:
            if !navigationPath.isEmpty {
                navigationPath.removeLast()
            }
        case .sheet:
            sheet = nil
            
        default:
            break
        }
        
    }
    
    func popToRoot() {
        navigationPath.removeAll()
        passedArguments.removeAll()
    }
    
    func selectTab(_ tab: AppTabs) {
        selectedTab = tab
    }
    
    
    @ViewBuilder
    func build(page: Destination) -> some View {
        switch page {
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
}
