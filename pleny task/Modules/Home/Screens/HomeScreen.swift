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
    @StateObject  private var searchText = DebouncedText(dueTime: 1)
    
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var showSearchBar: Bool = false
    
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 16) {
                HomeToolBar(searchText: $searchText.text)
                    .onChange(of: searchText.debouncedText, perform: { value in
                        Task{
                            await vm.getPosts(skip: 0,searchValue: value)
                        }
                    })
                    .frame(alignment: .top)
                
                
                switch vm.state {
                case .loading:
                    HomeLoadingShimmer()
                case .success:
                    PostListView(vm:vm, searchValue: $searchText.debouncedText)
                case .empty:
                    NoPostsView()
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
