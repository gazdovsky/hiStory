//
//  addComandButton.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 27.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct ComandButton: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .padding()
//        .addComandButton()
//        .strokedDashAnimated()
        .draggable()
    }
}

struct CommandButton: ViewModifier{
    @State var size: CGFloat = 20
    @State var icon = false
    @Binding var buttonVisible:Bool

    func body(content: Content) -> some View {
          content
            .overlay(
                GeometryReader{ geometry in
                    RoundedRectangle(cornerRadius: self.size/2)
                        .size(CGSize(width: self.size, height: self.size))
                        .position(CGPoint(x: geometry.size.width/2-self.size/1.618, y: geometry.size.height/2-self.size/1.618))
                        .frame(width: buttonVisible ? nil : 0, height: buttonVisible ? nil : 0, alignment: .center)
                }
        )
            
       
    }
}

//extension View{
//
//    func addComandButton( ) -> some View {
//        self.modifier(CommandButton())
//    }
//}

struct addComandButton_Previews: PreviewProvider {
    static var previews: some View {
        ComandButton()
    }
}
