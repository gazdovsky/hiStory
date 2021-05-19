//
//  кщефеуЕуые.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 13.05.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct rotateTest: View {
    @State var angle: Angle = .zero
    @State var hiddenAngle: Angle = .zero
    @State var recSize: CGSize = CGSize(width: 150, height: 80)
    @State var needSynchronizeAngle: Bool = true
    @State var rotateIconTranslation: CGSize = .zero
    var body: some View {
        Rectangle()
            .foregroundColor(.blue)
            .frame(width: recSize.width, height: recSize.height)
            .overlay(
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .offset(x: recSize.width / 2, y: -recSize.height / 2)
            )
            .rotationEffect(angle) //v1 if rotation effect applyed here, rectangle rotate as it should, but rotation icon dont move with it (pic. 1)
            .overlay(
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .opacity(0.0)
                    .contentShape(Rectangle())
                    .offset(x: recSize.width / 2, y: -recSize.height / 2)
                    .rotationEffect(hiddenAngle )
                    .gesture(DragGesture()
                                .onChanged{ value in
                                    var deltaRotateIconTranslation: CGSize = .zero
                                    if needSynchronizeAngle {
                                        deltaRotateIconTranslation = rotateIconTranslation
                                        needSynchronizeAngle = false
                                    }
                                    angle = calcRotationAngle(sumCGSize(value.translation, rotateIconTranslation))
                                }
                                .onEnded{ value in
                                    rotateIconTranslation = sumCGSize(value.translation, rotateIconTranslation)
                                    hiddenAngle = angle
                                }
                    )
            )
//            .rotationEffect(angle) //v2 if rotation effect applyed here, icon move with rectangle, but rotation become unpredictable (pic. 2)
        
    }
    func sumCGSize(_ a: CGSize, _ b: CGSize) -> CGSize {
        return CGSize(width: a.width + b.width, height: a.height + b.height)
    }
    func calcRotationAngle(_ translation: CGSize) -> Angle {
        Angle(radians: Double(
                atan2(translation.height - recSize.height / 2,
                      translation.width + recSize.width / 2 )))
    }
}

struct rotateTest2: View {
//    @State var
    @State var newX: CGFloat = 0
    @State var newY: CGFloat = 0
    @State var center: CGPoint = CGPoint(x: 175, y: 320)
    @State var dot: CGPoint = CGPoint(x: 330, y: 320) //330
    @State var newDot: CGPoint = CGPoint(x: 0, y: 0)
    @State var newRotate: Angle = .zero
    @State var supDegree: Double = .zero
    var body: some View {
        
        ZStack{
            Image("radimg")
                .resizable()
                .scaledToFit()
            Text("\(newRotate.degrees) \(supDegree) x: \(newDot.x + dot.x) y: \(newDot.y + dot.y)")
                .offset(x: 0, y: -200)
            Rectangle()
                .overlay(
                    Circle()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .frame(width: 20, height: 20)
                        .offset(x: 100, y: 0)
                        .gesture(DragGesture()
                                    .onChanged{ value in
//                                        let dotVelocity = CGPoint(x: value.translation.width + center.x, y: value.translation.height + center.y)
                                        let degrees = Angle(degrees: Double(
                                            
//                                            atan2(dot.x - value.translation.width, dot.y - value.translation.height)
//                                            atan2(value.translation.height, value.translation.width + 100)
//                                            atan2(center.y - dotVelocity.y, center.x - dotVelocity.x)
//                                            atan(value.translation.height / value.translation.width)
//                                            atan(value.translation.width / value.translation.height )
                                            atan2(value.translation.height, value.translation.width)
//                                            if(res<0) res += 360;
                                        ))
                                        
                                        var supposedDegree = Double(degrees.degrees)
                                        if  supposedDegree < .pi {
                                            supposedDegree = supposedDegree + .pi / 2
                                        } else  {
                                            supposedDegree = supposedDegree - .pi / 2
                                        }
                                        
                                        
//                                        var supposedDegree = newrotate + Double(degrees.degrees / 180 * .pi)
//                                        if supposedDegree > Double.pi * 2 {
//                                            supposedDegree = supposedDegree - Double.pi * 2
//                                        } else if supposedDegree < -Double.pi * 2 {
//                                                supposedDegree = supposedDegree + Double.pi * 2
//                                            }

                                       
                                        
                                        supDegree = supposedDegree
                                        newRotate = Angle(radians: supposedDegree)
                                        newDot = CGPoint(x: value.translation.width, y: value.translation.height)
                                    }
                        )
                )
                .frame(width: 300, height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(newRotate)
                .position(center)
                
            
            Circle()
                .frame(width: 30, height: 30)
//                .position(dot)
                .offset(x: newDot.x , y: newDot.y)
                //                   .position(x: newX)
                .gesture(DragGesture()
                            .onChanged{ value in
                                let dotVelocity = CGPoint(x: value.translation.width + dot.x, y: value.translation.height + dot.y)
                                let degrees = Angle(degrees: Double(
//                                    atan2(center.y - dotVelocity.y, center.x - dotVelocity.x) -
                                    atan2(dotVelocity.y - dot.y, dotVelocity.x - dot.x)



                                ))

                                var supposedDegree = Double(degrees.degrees)
//                                if supposedDegree > .pi  {
//                                    supposedDegree = supposedDegree - .pi
//                                } else if supposedDegree < -.pi  {
//                                    supposedDegree = supposedDegree + .pi
//                                }



                                supDegree = supposedDegree
                                newRotate = Angle(radians: supposedDegree)
                                newDot = CGPoint(x: value.translation.width, y: value.translation.height)
                            }
                )
        }
        
    }
}

struct rotateTest_Previews: PreviewProvider {
    static var previews: some View {
        rotateTest()
    }
}
