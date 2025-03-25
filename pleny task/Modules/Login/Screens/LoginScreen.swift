//
// 
//  LoginScreen.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI

struct LoginScreen: View {
    
    @ObservedObject private var vm = LoginViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var userName: String = ""
    @State private var password: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 0) {
                Image(.loginImg)
                    .imageSize(width: geo.size.width, height: geo.size.height / 2,aspect: .fill)
                    .ignoresSafeArea(.all, edges: .top)
                Spacer()
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .center, spacing: 24) {
                        Text("Welcome")
                            .textStyle(size: 20, color: AppColors.mainColor, weight: .bold, alignment: .center, textAlignment: .center)
                        
                        CustomTF(header: "User Name", placeholder: "Enter your user name", validationType: .username, error: $vm.userNameError, text: $userName)
                            .textInputAutocapitalization(.never)
                        
                        CustomTF(header: "Password", placeholder: "Enter your password", validationType: .password, isSecure: true, error: $vm.passwordError, text: $password)
                            .textInputAutocapitalization(.never)
                        
                        MainButton(title: "Sign in",loading: vm.state == .loading,isDisabled: !vm.isFormValid){
                            Log.d("Username: \(userName) \n password:\(password) \n errors: [\(vm.userNameError ?? "") -- \(vm.passwordError ?? "")]")
                            Task{
                                await vm.login(username: userName, password: password)
                            }
                        }
                        
                    }
                    .padding(.horizontal,16)
                    .padding(.bottom,16)
                }
            }
            
            
            
        }
        .alert(isPresented: Binding<Bool>(
            get: { vm.loginError != nil },
            set: { _ in }
        ), content: {
            Alert(title: Text("Error with login"), message: Text(vm.loginError?.error.errorDescription ?? ""), dismissButton: .default(Text("OK")))
        })
        .onTapGesture(perform: {
            AppHelper.dismissKeyboard()
        })
        .onChange(of: vm.state) { value in
            switch value {
            case .success:
                coordinator.replace(with: .main, replaceRoot: true)
            default:
                Log.d("view state",value)
            }
        }
        .onAppear {
            self.vm.onStart()
        }
        
    }
}

#Preview {
    LoginScreen()
}
