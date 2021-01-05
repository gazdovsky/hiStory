//
//  resisableText.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 03.06.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct transformingTextTest: View {
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
//            .strokedDashAnimated()
            .transformingText(fontName: "Vanilla", fontSize: 40)
    }
}

struct makeTransformingText: ViewModifier{
    @State var fontName: String
    @State var fontSize: CGFloat
    @State var newFontSize: CGFloat
    @State var currentPosition: CGSize = .zero
    @State var newPosition: CGSize = .zero
    @State var rotate: Angle = .zero
    
    func body(content: Content) -> some View{
        let mGesture =  MagnificationGesture(minimumScaleDelta: 0.1)
            .onChanged({scaleValue in
                if self.newFontSize * scaleValue < 400 && self.newFontSize * scaleValue > 6 {
                    self.fontSize = (self.newFontSize * scaleValue)
                }
            })
            .onEnded({_ in
                self.newFontSize = self.fontSize
            })
        let dGesture = DragGesture(minimumDistance: 5)
            .onChanged({value in
                self.currentPosition = CGSize(
                    width: value.translation.width + self.newPosition.width,
                    height: value.translation.height + self.newPosition.height)
            })
            .onEnded({ _ in
                self.newPosition = self.currentPosition
            })
        let rGesture = RotationGesture()
            .onChanged({degrees in
                self.rotate = degrees
            })
        let multiGesture = dGesture.simultaneously(with: mGesture).simultaneously(with: rGesture)
        
        return content
            .font(.custom(fontName, size: fontSize))
            .rotationEffect(rotate)
            .offset(self.currentPosition)
            .gesture(multiGesture)
    }
}

extension View{
    func transformingText(fontName : String, fontSize : CGFloat) -> some View{
        self.modifier(makeTransformingText(fontName : fontName, fontSize: fontSize, newFontSize: fontSize))
    }
}

struct transformingTextTest_Previews: PreviewProvider {
    static var previews: some View {
        transformingTextTest()
    }
}
