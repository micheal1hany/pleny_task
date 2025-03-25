//
//  TextField+Extension.swift

//
//  Created by Micheal Hany on 25/09/2024.
//

import SwiftUI

extension TextField{
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
                
            }
        }
}
