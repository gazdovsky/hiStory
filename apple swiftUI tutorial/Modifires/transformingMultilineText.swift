//
//  transformingMultilineText.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 20.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct transformingMultilineText: View {
    //    @ObservedObject var textData: selectorContainerStore = .shared
    var body: some View {
        Text("dd")
        //        TextView(fieldText:
        //                                    $textData.textContainers[1].fieldText,
        //                 fontSize: $textData.textContainers[1].fontSize, //$textData.textContainers[1].fontSize,
        //                                 textAlign: textData.textContainers[1].textAlign,
        //                                 fontName: textData.textContainers[1].fontName,
        //                                 fontColor: textData.textContainers[1].fontColor,
        //                                 index: 1,
        //                                 activeTextContainer: $textData.textContainers[1].activeTextContainer,
        //                                 isActive: $textData.textContainers[1].isActive)
        //            .modifier(makeTransformingMultilineText(index : 1, fontSize: textData.textContainers[1].fontSize))
        //            .fixedSize()
    }
}

struct makeTransformingMultilineText: ViewModifier{
    //    @ObservedObject var textData: selectorContainerStore = .shared
    @ObservedObject var textData: textContainersFrameData = .shared
    //    @State var fontName: String
    @State var index: Int
    @State var fontSize: CGFloat
//    @State var width: CGFloat
//    @State var increaser: CGFloat
    @State var newFontSize: CGFloat = .zero
    
    @State var currentScaleValue: CGFloat = 1
    @State var newSaleValue: CGFloat = 1
    
    
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
//                if needSynchronizeMagnification {
//                    newFontSize = textData.textContainers[index].fontSize
//                    needSynchronizeMagnification = false
//                }
//                if newFontSize * scaleValue < 400 &&  newFontSize * scaleValue > 6 {
//                    textData.textContainers[index].fontSize = ( newFontSize * scaleValue)
//                }
//                width = newSaleValue * scaleValue
                
            })
            .onEnded({_ in
//                newFontSize = textData.textContainers[index].fontSize
                newSaleValue = currentScaleValue
                
            })
        let dGesture = DragGesture(minimumDistance: 5)
            .onChanged({value in
                if needSynchronizeDrag {
                    newPosition = textData.textContainers[index].transform.currentPosition
                    needSynchronizeDrag = false
                }
                textData.textContainers[index].transform.currentPosition = CGSize(
                    width: value.translation.width + newPosition.width,
                    height: value.translation.height + newPosition.height)
            })
            .onEnded({ _ in
                newPosition = textData.textContainers[index].transform.currentPosition
            })
        let rGesture = RotationGesture()
            .onChanged({degrees in
                if needSynchronizeAngle {
                    newrotate = textData.textContainers[index].transform.rotate
                    needSynchronizeAngle = false
                }
                textData.textContainers[index].transform.rotate = newrotate + Double(degrees.degrees / 180 * .pi)
            })
            .onEnded({_ in
                newrotate = textData.textContainers[index].transform.rotate
            })
        let multiGesture = dGesture.simultaneously(with: mGesture).simultaneously(with: rGesture)
        
        return content
            .rotationEffect(Angle(degrees: textData.textContainers[index].transform.rotate * 180 / .pi))
            .offset(textData.textContainers[index].transform.currentPosition)
//            .scaleEffect(currentScaleValue)
            .gesture(multiGesture)
    }
}

struct transformingMultilineText_Previews: PreviewProvider {
    static var previews: some View {
        transformingMultilineText()
    }
}
