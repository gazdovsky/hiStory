//
//  StrokedDashAnimation.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 27.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct activeBorderTest: View {
    @State var dash: Bool = false
    var body: some View {
        SwiftUIPhotoSelector()
            .frame(width: 300,
                   height: 300)
            .mask(
                Rectangle()
                    .frame(width : 300,
                           height: 300)
            )
            .contentShape(
                Rectangle()
            )
            .position(x: 150, y: 150)
            .modifier(StrokeDashAnimation(isVisible: $dash))
            .onTapGesture {
                dash.toggle()
            }
        
    }
}

struct activeBorder: ViewModifier{

    @State var moveAlong = false
    @Binding var isVisible: Bool
    
    func body(content: Content) -> some View {
        
        content
            .overlay(GeometryReader{g in
                RoundedRectangle(cornerRadius: 2)
                    .stroke(style: StrokeStyle(lineWidth: 1, miterLimit: CGFloat(10.7), dash: [5,5], dashPhase: self.moveAlong ? 0 : 30))
                    .frame(width: isVisible ? g.size.width : 0, height: isVisible ? g.size.height : 0)
                .fixedSize()
                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false).speed(2), value: self.moveAlong)
                    
                    .onAppear(){
                        self.moveAlong.toggle()
                }
                
                }
        )
//        .rotationEffect(Angle(degrees: 0)) //This modifier for some reason prevent  animation of moving strokedDashAnimated when use both of them
        
    }
}

//extension View{
//
//    func strokedDashAnimated() -> some View {
//             self.modifier(StrokeDashAnimation())
//    }
//}

struct activeBorderTest_Previews: PreviewProvider {
    static var previews: some View {
        activeBorderTest()
    }
}
