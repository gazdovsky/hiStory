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
//    @State var fontSize: CGFloat
    //    @State var width: CGFloat
    //    @State var increaser: CGFloat
    @State var expectFontSize: CGFloat = 1
    @State var newFontSize: CGFloat = 1
    @State var newContainerW: CGFloat = 1
    @State var newSaleValue: CGFloat = 1
    @State var newPosition: CGSize = .zero
    @State var newrotate: Double = 0.0
    @State var needSynchronizeMagnification: Bool = true
    @State var needSynchronizeDrag: Bool = true
    @State var needSynchronizeAngle: Bool = true
    @State var increaser: CGFloat
    var actualTemplateWidth: CGFloat {
        increaser * 1080
    }
    @Binding var activeContainer: textFieldContainer
    @GestureState var isScaleActive: Bool = false
    @GestureState var isDragActive: Bool = false
    @GestureState var isRotateActive: Bool = false
    var centerizeDelta: CGFloat = 10

    func body(content: Content) -> some View{
        let dGesture = DragGesture(minimumDistance: 5)
            .updating($isDragActive) { (value, gestureState, transaction) in
                gestureState = true
            }
            .onChanged({value in
                if needSynchronizeDrag {
                    newPosition = textData.textContainers[index].transform.currentPosition
                    needSynchronizeDrag = false
                }
                // 80...120 ~=
                let supposedWidth = value.translation.width + newPosition.width
                let supposedHeight = value.translation.height + newPosition.height
                //
                let centerX = (increaser * 1080) / 2 - (textData.textContainers[index].x * increaser)
                let centerY = (increaser * 1920) / 2 - (textData.textContainers[index].y * increaser)
                //
                enum side {
                    case w,h
                }
                struct magnetPositionInfo {
                    var position: CGFloat
                    var isMagnet: Bool
                }
                func magnetPosition(_ side: side ) -> magnetPositionInfo {
                    let offset: CGFloat = side == .w ? 10 : 40
                    let textFieldSide = side == .w ? activeContainer.containerW : activeContainer.containerH
                    let teplateSide = side == .w ? actualTemplateWidth : actualTemplateWidth * (1920 / 1080)
                    let center = side == .w ? centerX : centerY
                    let supposedPosition = side == .w ? supposedWidth : supposedHeight
                    let magnetPoints: [CGFloat] = [
                        center,
                        center - teplateSide/2 + textFieldSide/2 * increaser + offset,
                        center + teplateSide/2 - textFieldSide/2 * increaser - offset
                    ]
                    
                    for (i, point) in magnetPoints.enumerated() {
                        if point - centerizeDelta...point + centerizeDelta ~= supposedPosition{
                            if side == .w {
                                switch i {
                                case 0:
                                    textData.centerXLineVisible = true
                                case 1:
                                    textData.leftXLineVisible = true
                                case 2:
                                    textData.rightXLineVisible = true
                                default:
                                    break
                                }
                            } else if side == .h {
                                switch i {
                                case 0:
                                    textData.centerYLineVisible = true
                                case 1:
                                    textData.topYLineVisible = true
                                case 2:
                                    textData.bottomYLineVisible = true
                                default:
                                    break
                                }
                            }
                           return magnetPositionInfo(position: point, isMagnet: true)
                        }
                    }
                    switch side {
                    case .w:
                        textData.leftXLineVisible = false
                        textData.centerXLineVisible = false
                        textData.rightXLineVisible = false
                    case .h:
                        textData.topYLineVisible = false
                        textData.centerYLineVisible = false
                        textData.bottomYLineVisible = false
                    }
                   
                    return  magnetPositionInfo(position: supposedPosition, isMagnet: false)
                }
                
               
                let w =  withAnimation{ magnetPosition(.w) }
                let h =  withAnimation{ magnetPosition(.h) }
                if w.isMagnet {
                    withAnimation{
                        textData.textContainers[index].transform.currentPosition.width = w.position
                    }
                } else {
                    textData.textContainers[index].transform.currentPosition.width = w.position
                }
                if h.isMagnet {
                    withAnimation{
                        textData.textContainers[index].transform.currentPosition.height = h.position
                    }
                } else {
                    textData.textContainers[index].transform.currentPosition.height = h.position
                }
                
//                    textData.textContainers[index].transform.currentPosition = CGSize(
//                        width: magnetPosition(.w).position,
//                        height: magnetPosition(.h).position
//                    )
                
                
//                if centerX - centerizeDelta...centerX + centerizeDelta ~= supposedWidth {
//                    textData.centerXLineVisible = true
//                } else {
//                    textData.centerXLineVisible = false
//                }
//
//                if centerY - centerizeDelta...centerY + centerizeDelta ~= supposedHeight {
//                    textData.centerYLineVisible = true
//                } else {
//                    textData.centerYLineVisible = false
//                }
                
                
            })
            .onEnded({ _ in
                newPosition = textData.textContainers[index].transform.currentPosition
                textData.centerYLineVisible = false
                textData.centerXLineVisible = false
                textData.leftXLineVisible = false
                textData.rightXLineVisible = false
                textData.topYLineVisible = false
                textData.bottomYLineVisible = false
            })
        let rGesture = RotationGesture()
            .updating($isRotateActive) { (value, gestureState, transaction) in
                gestureState = true
            }
            .onChanged({degrees in
                if needSynchronizeAngle {
                    newrotate = textData.textContainers[index].transform.rotate
                    needSynchronizeAngle = false
                }
                
                var supposedDegree = newrotate + Double(degrees.degrees / 180 * .pi)
                if supposedDegree > Double.pi * 2 {
                    supposedDegree = supposedDegree - Double.pi * 2
                } else if supposedDegree < -Double.pi * 2 {
                        supposedDegree = supposedDegree + Double.pi * 2
                    }
                
                //
                let deltaDegree = Double(0.1)
                
                func newAngle() -> Double {
                    let fixPointsNumber: Int = 8
                    var fixPoints: [Double] = []
                    let fixStep: Double = (2 * Double.pi) / Double(fixPointsNumber)
                    var aligns: [ClosedRange<Double>] = []
                    for i in 0..<fixPointsNumber {
                        fixPoints.append(fixStep * Double(i))
                        aligns.append(fixPoints[i] - deltaDegree...fixPoints[i] + deltaDegree)
                        if aligns[i] ~= abs(supposedDegree) {
                        return fixPoints[i] * (abs(supposedDegree) / supposedDegree)
                        }
                    }
                    return supposedDegree
                }
                
//               print(supposedDegree)
                
                textData.textContainers[index].transform.rotate = newAngle()
                
               
            })
            .onEnded({_ in
                newrotate = textData.textContainers[index].transform.rotate
                textData.centerYLineVisible = false
                textData.centerXLineVisible = false
            })
        let multiGesture = dGesture.simultaneously(with: rGesture)
        
        return content
            .scaleEffect(newSaleValue)
            .rotationEffect(Angle(degrees: activeContainer.transform.rotate * 180 / .pi))
            .offset(offset)
            .gesture(multiGesture)
            .onAppear {
                    textData.centerYLineVisible = false
                    textData.centerXLineVisible = false
            }
    }
    var offset: CGSize {
        if increaser == 1 || increaser < 0.1 || increaser == 2 || increaser == 0.5 {
//            print( "1", actualTemplateWidth, increaser, textData.increaser, textData.textContainers[index].transform.currentPosition.debugDescription )
            return CGSize(width: textData.textContainers[index].transform.currentPosition.width * textData.textIncreaser * (actualTemplateWidth/1080),
                          height: textData.textContainers[index].transform.currentPosition.height * textData.textIncreaser * (actualTemplateWidth/1080))
        } else {
//            print( "2", actualTemplateWidth, increaser, textData.increaser, textData.textContainers[index].transform.currentPosition.debugDescription )
            return textData.textContainers[index].transform.currentPosition
        }
    }
}

struct transformingMultilineText_Previews: PreviewProvider {
    static var previews: some View {
        transformingMultilineText()
    }
}
