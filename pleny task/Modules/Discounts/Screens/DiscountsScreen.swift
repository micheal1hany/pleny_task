//
// 
//  DiscountsScreen.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI

struct DiscountsScreen: View {
    
    @StateObject private var vm = DiscountsViewModel()
    
    var body: some View {
        VStack {
            NavigationButton(sheet: .home) {
                Text("Go to Home sheet")
            }
            
            Text("DiscountsScreen")
        }
    }
}

#Preview {
    DiscountsScreen()
}
