//
//  transformingMultilineText.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 20.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct transformingMultilineText: View {
    //    @ObservedObject var redactor.textFields: selectorContainerStore = .shared
    var body: some View {
        Text("dd")
        //        TextView(fieldText:
        //                                    $redactor.textFields.textContainers[1].fieldText,
        //                 fontSize: $redactor.textFields.textContainers[1].fontSize, //$redactor.textFields.textContainers[1].fontSize,
        //                                 textAlign: redactor.textFields.textContainers[1].textAlign,
        //                                 fontName: redactor.textFields.textContainers[1].fontName,
        //                                 fontColor: redactor.textFields.textContainers[1].fontColor,
        //                                 index: 1,
        //                                 activeTextContainer: $redactor.textFields.textContainers[1].activeTextContainer,
        //                                 isActive: $redactor.textFields.textContainers[1].isActive)
        //            .modifier(makeTransformingMultilineText(index : 1, fontSize: redactor.textFields.textContainers[1].fontSize))
        //            .fixedSize()
    }
}

struct makeTransformingMultilineText: ViewModifier{
    //    @ObservedObject var redactor.textFields: selectorContainerStore = .shared
//    @ObservedObject var redactor.textFields: textContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
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
    @Binding var hiddenAngle: Angle
    @GestureState var isScaleActive: Bool = false
    @GestureState var isDragActive: Bool = false
    @GestureState var isRotateActive: Bool = false
    var centerizeDelta: CGFloat = 2

    func body(content: Content) -> some View{
        let dGesture = DragGesture(minimumDistance: 5)
            .updating($isDragActive) { (value, gestureState, transaction) in
                gestureState = true
            }
            .onChanged({value in
                if needSynchronizeDrag {
                    newPosition = redactor.textFields.textContainers[index].transform.currentPosition
                    needSynchronizeDrag = false
                }
                // 80...120 ~=
                let supposedWidth = value.translation.width + newPosition.width
                let supposedHeight = value.translation.height + newPosition.height
                //
                let centerX = (increaser * 1080) / 2 - (redactor.textFields.textContainers[index].x * increaser)
                let centerY = (increaser * 1920) / 2 - (redactor.textFields.textContainers[index].y * increaser)
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
                                    redactor.textFields.centerXLineVisible = true
                                case 1:
                                    redactor.textFields.leftXLineVisible = true
                                case 2:
                                    redactor.textFields.rightXLineVisible = true
                                default:
                                    break
                                }
                            } else if side == .h {
                                switch i {
                                case 0:
                                    redactor.textFields.centerYLineVisible = true
                                case 1:
                                    redactor.textFields.topYLineVisible = true
                                case 2:
                                    redactor.textFields.bottomYLineVisible = true
                                default:
                                    break
                                }
                            }
                           return magnetPositionInfo(position: point, isMagnet: true)
                        }
                    }
                    switch side {
                    case .w:
                        redactor.textFields.leftXLineVisible = false
                        redactor.textFields.centerXLineVisible = false
                        redactor.textFields.rightXLineVisible = false
                    case .h:
                        redactor.textFields.topYLineVisible = false
                        redactor.textFields.centerYLineVisible = false
                        redactor.textFields.bottomYLineVisible = false
                    }
                   
                    return  magnetPositionInfo(position: supposedPosition, isMagnet: false)
                }
                
               
                let w =  withAnimation{ magnetPosition(.w) }
                let h =  withAnimation{ magnetPosition(.h) }
                if w.isMagnet {
                    withAnimation{
                        redactor.textFields.textContainers[index].transform.currentPosition.width = w.position
                    }
                } else {
                    redactor.textFields.textContainers[index].transform.currentPosition.width = w.position
                }
                if h.isMagnet {
                    withAnimation{
                        redactor.textFields.textContainers[index].transform.currentPosition.height = h.position
                    }
                } else {
                    redactor.textFields.textContainers[index].transform.currentPosition.height = h.position
                }
                
            })
            .onEnded({ _ in
                newPosition = redactor.textFields.textContainers[index].transform.currentPosition
                redactor.textFields.centerYLineVisible = false
                redactor.textFields.centerXLineVisible = false
                redactor.textFields.leftXLineVisible = false
                redactor.textFields.rightXLineVisible = false
                redactor.textFields.topYLineVisible = false
                redactor.textFields.bottomYLineVisible = false
            })
        let rGesture = RotationGesture()
            .updating($isRotateActive) { (value, gestureState, transaction) in
                gestureState = true
            }
            .onChanged({degrees in
                if needSynchronizeAngle {
                    newrotate = redactor.textFields.textContainers[index].transform.rotate
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
                
                redactor.textFields.textContainers[index].transform.rotate = newAngle()
                
               
            })
            .onEnded({_ in
                newrotate = redactor.textFields.textContainers[index].transform.rotate
                redactor.textFields.centerYLineVisible = false
                redactor.textFields.centerXLineVisible = false
                hiddenAngle = Angle(degrees: activeContainer.transform.rotate * 180 / .pi)
            })
        let multiGesture = dGesture.simultaneously(with: rGesture)
        
        return content
            .scaleEffect(newSaleValue)
            
//            .rotationEffect(Angle(degrees: activeContainer.transform.rotate * 180 / .pi))
            .offset(offset)
            .gesture(multiGesture)
            .onAppear {
                    redactor.textFields.centerYLineVisible = false
                    redactor.textFields.centerXLineVisible = false
            }
    }
    var offset: CGSize {
        if increaser == 1 || increaser < 0.1 || increaser == 2 || increaser == 0.5 {
//            print( "1", actualTemplateWidth, increaser, redactor.textFields.increaser, redactor.textFields.textContainers[index].transform.currentPosition.debugDescription )
            return CGSize(width: redactor.textFields.textContainers[index].transform.currentPosition.width * redactor.textFields.textIncreaser * (actualTemplateWidth/1080),
                          height: redactor.textFields.textContainers[index].transform.currentPosition.height * redactor.textFields.textIncreaser * (actualTemplateWidth/1080))
        } else {
//            print( "2", actualTemplateWidth, increaser, redactor.textFields.increaser, redactor.textFields.textContainers[index].transform.currentPosition.debugDescription )
            return redactor.textFields.textContainers[index].transform.currentPosition
        }
    }
}

struct transformingMultilineText_Previews: PreviewProvider {
    static var previews: some View {
        transformingMultilineText()
    }
}
