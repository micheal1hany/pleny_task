//
// 
//  ProfileScreen.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI

struct ProfileScreen: View {
    
    @ObservedObject private var vm = ProfileViewModel()
    
    var body: some View {
        Text("ProfileScreen")
    }
}

#Preview {
    ProfileScreen()
}
