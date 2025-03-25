//
//  View+Extension.swift
//  swiftui_movies_example
//
//  Created by Micheal Hany on 06/11/2023.
//

import SwiftUI
internal import Shimmer

extension View{
    
    @ViewBuilder func embedNavigationView()-> some View{
        NavigationView {
            self
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden()
    }
    
    
    func dimissKeyboardOnTapOutside()-> some View{
        self.onTapGesture {
            let resign = #selector(UIResponder.resignFirstResponder)
            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        }
    }
    
    @ViewBuilder func customShimmer(_ active:Bool) -> some View{
        self
            .redacted(reason: active ? .placeholder: [])
            .shimmering(active: active)
    }
    
    @ViewBuilder func customToolBar(_ title:LocalizedStringKey,systemIcon:String? = nil, presentationMode:Binding<PresentationMode>, @ViewBuilder actions: @escaping ()-> some View = {EmptyView()})-> some View{
            
            self
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack(alignment: .center, spacing: 12, content: {
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                if systemIcon == nil{
                                    Image(.closeIcon)
                                        .frame(width: 8, height: 14)
                                        .foregroundColor(.black)
                                }else{
                                    Image(systemName: systemIcon ?? "xmark")
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.black)
                                }
                                
                            }
                            
                            Text(title)
                                .textStyle(size: 16, color: .black,weight: .semibold)
                        })
                        
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        actions()
                    }
                }
            .padding(.top,20)
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
    }
    
    
    @ViewBuilder func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    
    @ViewBuilder private func textSize(size:CGFloat,weight:Font.Weight? = .regular) -> some View{
        self.font(Font.system(size: size, weight: weight))
    }
    
    @ViewBuilder func textStyle(size:CGFloat,color:String,weight:Font.Weight? = .regular,alignment:Alignment = .center,textAlignment:TextAlignment = .center)-> some View{
        self.textSize(size: size,weight: weight)
            .foregroundColor(Color(hex: color))
            .frame(alignment: alignment)
            .multilineTextAlignment(textAlignment)
    }
    
    @ViewBuilder func textStyle(size:CGFloat,color:Color,weight:Font.Weight? = .regular,alignment:Alignment = .center,textAlignment:TextAlignment = .center)-> some View{
        self.textSize(size: size,weight: weight)
            .foregroundColor(color)
            .frame(alignment: alignment)
            .multilineTextAlignment(textAlignment)
    }
    
    func snapshot() async -> UIImage? {
        return await withCheckedContinuation { continuation in
            let controller = UIHostingController(
                rootView: self.fixedSize(horizontal: true, vertical: true))
            guard let view = controller.view else { return continuation.resume(returning: nil) }
            
            let targetSize = view.intrinsicContentSize // to capture entire scroll content
            
            if targetSize.width <= 0 || targetSize.height <= 0 { return continuation.resume(returning: nil) }
            
            view.bounds = CGRect(origin: .zero, size: targetSize)
            
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            
            let snapshot = renderer.image { rendererContext in
                view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
            }
            
            return continuation.resume(returning: snapshot)
        }
    }
    
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
