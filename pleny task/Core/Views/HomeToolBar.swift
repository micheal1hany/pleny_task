//
//  HomeToolBar.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//

import SwiftUI

struct HomeToolBar:View {
    
    @State private var showSearch:Bool = false
    @Binding var searchText:String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if !showSearch{
                Image(.logo)
                    .imageSize(width: 60, height: 16)
                
                Spacer()
                
                
                Button {
                    showSearch.toggle()
                } label: {
                    Image(.searchIcon)
                        .imageSize(width: 24, height: 24)
                }
            }else{
                CustomTF(placeholder: "Search Posts", error: .constant(nil), text: $searchText)
                    
            }

        }
        .padding(.horizontal,16)
    }
}
