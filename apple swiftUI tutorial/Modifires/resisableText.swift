//
//  resisableText.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 03.06.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct resisableTextTest: View {

    var body: some View {
        Text("Hello, World!")
//        .resisableText(fontSize: 40)
//            .font(.custom("Vanilla", size: 40))
            .padding()
//            .strokedDashAnimated()
            .resisableText(fontName: "Vanilla", fontSize: 40)
        
        
    }
}

struct makeResisableText: ViewModifier{
    @State var fontName: String
    @State var fontSize: CGFloat
    @State  var newFontSize: CGFloat
    
    
    
    func body(content: Content) -> some View{
        content
            .font(.custom(fontName, size: fontSize))
            .gesture(
                MagnificationGesture(minimumScaleDelta: 0.01)
                    .onChanged({scaleValue in
                        self.fontSize = self.newFontSize * scaleValue
                    })
                    .onEnded({_ in
                        self.newFontSize = self.fontSize
                    })
        )
    }
}

extension View{
    func resisableText(fontName : String, fontSize : CGFloat) -> some View{
        
        self.modifier(makeResisableText(fontName : fontName, fontSize: fontSize, newFontSize: fontSize))
    }
}

struct resisableTextTest_Previews: PreviewProvider {
    static var previews: some View {
        resisableTextTest()
    }
}
