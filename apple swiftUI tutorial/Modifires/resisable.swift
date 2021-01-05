//
//  resisable.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 03.06.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct resisableTest: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .draggable()
//            .resisableText(fontSize: 40)
        
            
    }
}

//struct makeResisableText: ViewModifier{
//    @State var fontSize:   CGFloat
//    @State  var newFontSize:   CGFloat
//
//
//    func body(content: Content) -> some View{
//        content
//            .font(.system(size: fontSize))
//            .gesture(
//                MagnificationGesture(minimumScaleDelta: 0.01)
//                    .onChanged({scaleValue in
//                        self.fontSize = self.newFontSize * scaleValue
//                    })
//                    .onEnded({_ in
//                        self.newFontSize = self.fontSize
//                    }))
//    }
//}
//
//extension View{
//    func resisableText(fontSize : CGFloat) -> some View{
//
//        self.modifier(makeResisableText(fontSize: fontSize, newFontSize: fontSize))
//    }
//}

struct makeResisable: ViewModifier{
    @State private var currentScale:   CGFloat = 1.0
    @State private var     newScale:   CGFloat = 1.0
    
    func body(content: Content) -> some View{
        content
            .scaleEffect(currentScale)
            .gesture(
                MagnificationGesture(minimumScaleDelta: 0.01)
                    .onChanged({scaleValue in
                        self.currentScale = self.newScale * scaleValue
                    })
                    .onEnded({_ in
                        self.newScale = self.currentScale
                    }))
    }
}

extension View{
    func resisable() -> some View{
        self.modifier(makeResisable())
    }
}

struct resisable_Previews: PreviewProvider {
    static var previews: some View {
        resisableTest()
    }
}
