//
//  resisableText.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 03.06.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct itemsInFrame: View {

    var body: some View {
            ZStack{
                Rectangle()
                    .overlay(
                        Image("Iphone 11 pro max")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .scaledToFill()
                    )
                    
                    HStack {
//                        mainNavigationButton(text: "Templates")
//                        mainNavigationButton(text: "My stories")
                    }
                    .offset(x:0,y:-365)
        }
    }
}

struct makeitemsInFrame: ViewModifier{
    var width: CGFloat //= 0
    var height: CGFloat //= 80
    var cornerRadius: CGFloat// = 20
    var color: Color // = .white

    func body(content: Content) -> some View{
        ZStack{
            Rectangle()
                .frame(width: width != 0 ? width : nil, height: height != 0 ? height : nil)
//            .foregroundColor(Color(hex: "f4d8c8"))
            .foregroundColor(color)
            .cornerRadius(cornerRadius)
           content
        }
        
    }
}

extension View{
   
    func itemsInFrame(with width:CGFloat = 0, height:CGFloat = 80, cornerRadius: CGFloat = 20, color: Color = .white) -> some View{
        
        self.modifier(makeitemsInFrame(width: width, height: height, cornerRadius: cornerRadius, color: color))
    }
}

struct itemsInFrame_Previews: PreviewProvider {
    static var previews: some View {
        itemsInFrame()
            .previewDevice("iPhone 11 Pro Max")
    }
}

struct mainNavigationButton: View {
    var text: String
    var color: Color = .white
    var action: (()->()) = {}
//    var color: Color
    var body: some View{
        Button(action: {
            action()
        }, label: {
            Text(text)
                .frame(width: 100, height: nil)
                .font(.custom("Times New Roman", size: 22))
                
                .foregroundColor(.white)
                
                
                
                
                
        })
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .padding([.top,.bottom],5)
        .itemsInFrame(with: 0,height: 0,cornerRadius: 10,color: color )
            .fixedSize()
    }
}
