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
    
    @ObservedObject private var vm = DiscountsViewModel()
    
    var body: some View {
        Text("DiscountsScreen")
    }
}

#Preview {
    DiscountsScreen()
}
