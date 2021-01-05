//
//  transformingMultilineText.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 20.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct transformingMultilineText: View {
    @ObservedObject var settings: selectorContainerStore = .shared
    var body: some View {
        Text("dd")
//        TextView(fieldText:
//                                    $settings.textContainers[1].fieldText,
//                 fontSize: $settings.textContainers[1].fontSize, //$settings.textContainers[1].fontSize,
//                                 textAlign: settings.textContainers[1].textAlign,
//                                 fontName: settings.textContainers[1].fontName,
//                                 fontColor: settings.textContainers[1].fontColor,
//                                 index: 1,
//                                 activeTextContainer: $settings.textContainers[1].activeTextContainer,
//                                 isActive: $settings.textContainers[1].isActive)
//            .modifier(makeTransformingMultilineText(index : 1, fontSize: settings.textContainers[1].fontSize))
//            .fixedSize()
    }
}

struct makeTransformingMultilineText: ViewModifier{
    @ObservedObject var settings: selectorContainerStore = .shared
//    @State var fontName: String
    @State var index: Int
    @State var fontSize: CGFloat
    @State var newFontSize: CGFloat = .zero
    @State var currentPosition: CGSize = .zero
    @State var newPosition: CGSize = .zero
    @State var rotate: Double = 0.0
    @State var newrotate: Double = 0.0
    @State var needSynchronizeMagnification: Bool = true
    @State var needSynchronizeDrag: Bool = true
    @State var needSynchronizeAngle: Bool = true
    
    func body(content: Content) -> some View{
        let mGesture =  MagnificationGesture(minimumScaleDelta: 0.1)
            .onChanged({scaleValue in
                if self.needSynchronizeMagnification {
                    self.newFontSize = self.settings.textContainers[index].fontSize
                    self.needSynchronizeMagnification = false
                }
                if self.newFontSize * scaleValue < 400 && self.newFontSize * scaleValue > 6 {
                    self.settings.textContainers[index].fontSize = (self.newFontSize * scaleValue)
                }
//                else {
//                    self.newFontSize = self.settings.textContainers[index].fontSize
//                }
            })
            .onEnded({_ in
                self.newFontSize = self.settings.textContainers[index].fontSize
            })
        let dGesture = DragGesture(minimumDistance: 5)
            .onChanged({value in
                if self.needSynchronizeDrag {
self.newPosition = self.settings.textContainers[index].transform.currentPosition
                    self.needSynchronizeDrag = false
                }
                
                self.settings.textContainers[index].transform.currentPosition = CGSize(
                    width: value.translation.width + self.newPosition.width,
                    height: value.translation.height + self.newPosition.height)
            })
            .onEnded({ _ in
                self.newPosition = self.settings.textContainers[index].transform.currentPosition
            })
        let rGesture = RotationGesture()
            .onChanged({degrees in
                if self.needSynchronizeAngle {
                    self.newrotate = self.settings.textContainers[index].transform.rotate
                    self.needSynchronizeAngle = false
                }
                self.settings.textContainers[index].transform.rotate = self.newrotate + Double(degrees.degrees / 180 * .pi)
            })
            .onEnded({_ in
                self.newrotate = self.settings.textContainers[index].transform.rotate
            })
        let multiGesture = dGesture.simultaneously(with: mGesture).simultaneously(with: rGesture)
        
        return content
//            .font(.custom(fontName, size: fontSize))
            .rotationEffect(Angle(degrees: self.settings.textContainers[index].transform.rotate * 180 / .pi))
            .offset(self.settings.textContainers[index].transform.currentPosition)
            .gesture(multiGesture)
    }
}

struct transformingMultilineText_Previews: PreviewProvider {
    static var previews: some View {
        transformingMultilineText()
    }
}
