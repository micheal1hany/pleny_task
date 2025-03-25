//
//  MainButton.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//

import SwiftUI
import LoaderUI

struct MainButton: View {
    
    var title:LocalizedStringKey?
    var backgroundColor:Color?
    var textColor:String?
    var loading:Bool? = false
    var isDisabled: Bool = false
    var buttonAction: ()->Void
    
    var body: some View {
        Button {
            if !isDisabled {
                buttonAction()
            }
        } label: {
            if loading == true{
                CircleStrokeSpin()
                    .frame(width: 24,height:24,alignment: .center)
                    .foregroundColor(.white)
                    .padding(8)
            }else{
                Text(title ?? "Ok")
                    .textStyle(size: 16, color: isDisabled ? .white : .white, weight: .semibold, alignment: .center, textAlignment: .center)
                    .frame(maxWidth: .infinity,minHeight: 46)
                    .background(RoundedRectangle(cornerRadius: 32).fill(isDisabled ? .gray:backgroundColor ?? Color(hex: AppColors.mainColor)))
            }
            
        }
        .frame(maxWidth: .infinity,minHeight: 46)
        .background(RoundedRectangle(cornerRadius: 32).fill(isDisabled ? .gray:backgroundColor ?? Color(hex: AppColors.mainColor)))
        .disabled(isDisabled)
        
        
    }
}
//
//#Preview {
//    MainButton()
//}
