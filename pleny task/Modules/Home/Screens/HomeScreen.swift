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
    
    @StateObject private var vm = HomeViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var showSearchBar: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 16) {
                HomeToolBar(searchText: $searchText)
                    .frame(alignment: .top)
                
                
                switch vm.state {
                case .loading:
                    HomeLoadingShimmer()
                case .success:
                    PostListView(posts: vm.posts)
                        .refreshable {
                            Task{
                                await vm.getPosts(skip: 0)
                            }
                        }
                    
                default:
                    EmptyView()
                }
            }
        }
        
        .onAppear {
            Task{
                await vm.getPosts(skip: 0)
            }
        }
        
    }
}

#Preview {
    HomeScreen()
}
