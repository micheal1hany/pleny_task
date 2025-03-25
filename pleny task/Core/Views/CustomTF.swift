//
//  CustomTF.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//

import SwiftUI

struct CustomTF: View {
    var header: String? = nil
    var placeholder: String
    var validationType: TextFieldValidator.FieldType? = nil
    var isSecure: Bool = false
    var prefixIcon: Image? = nil
    var suffixIcon: Image? = nil

    @Binding var error: String?
    @Binding var text: String
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let header = header {
                Text(header)
                    .textStyle(size: 16, color: AppColors.secondaryColor, weight: .semibold, alignment: .leading, textAlignment: .leading)
            }
            
            HStack {
                // Prefix Icon
                if let prefixIcon = prefixIcon {
                    prefixIcon
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                }
                
                ZStack(alignment: .trailing) {
                    if isSecure && !isPasswordVisible {
                        SecureField(placeholder, text: $text)
                            .textFieldStyle(.roundedBorder)
                            .frame(height: 42)
                            .onChange(of: text) { value in
                                validate(value)
                            }
                    } else {
                        TextField(placeholder, text: $text)
                            .textFieldStyle(.roundedBorder)
                            .frame(height: 42)
                            .onChange(of: text) { value in
                                validate(value)
                            }
                    }
                    
                    // Suffix Icons (Eye for secure fields & custom suffix)
                    HStack {
                        if let suffixIcon = suffixIcon {
                            suffixIcon
                                .foregroundColor(.gray)
                        }
                        if isSecure {
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.trailing, 10)
                }
            }
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
            
            if let error = error {
                Text(error)
                    .textStyle(size: 14, color: .red, weight: .regular, alignment: .leading, textAlignment: .leading)
                    .animation(.easeIn, value: error)
            }
        }
    }
    
    private func validate(_ value: String) {
        switch validationType {
        case .requiredField:
            self.error = TextFieldValidator.validateEmptyValue(value)
        case .username:
            self.error = TextFieldValidator.validateUserName(value)
        case .none:
            break
        default:
            self.error = TextFieldValidator.validateEmptyValue(value)
        }
    }
}
