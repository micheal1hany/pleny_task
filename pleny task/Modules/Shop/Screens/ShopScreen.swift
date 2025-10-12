//
// 
//  ShopScreen.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI

struct ShopScreen: View {
    
    @StateObject private var vm = ShopViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack{
            NavigationButton(push: .gallery) {
                Text("Go to gallery")
            }
            Text("Shop Screen")
        }
        
//        Button {
//            coordinator.navigate(to: .sheet(.gallery))
//        } label: {
//            Text("Go to gallery")
//        }

    }
}

#Preview {
    ShopScreen()
}
