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
    
    @StateObject private var vm = ProfileViewModel()
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack{
            Button {
                coordinator.navigate(to: .push(.login))
            } label: {
                Text("Navigate to Login from coordinator")
            }

            Text("ProfileScreen")
        }
        
    }
}

#Preview {
    ProfileScreen()
}
