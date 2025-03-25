//
// 
//  HomeScreen.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject private var vm = HomeViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var showSearchBar: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 16) {
                HomeToolBar(searchText: $searchText)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 0) {
                        Text("Home screen")
                        
                        Button("Go to Gallery") {
                            coordinator.push(.gallery)
                        }
                    }
                }
            }
            
            
        }
        
    }
}

#Preview {
    HomeScreen()
}
