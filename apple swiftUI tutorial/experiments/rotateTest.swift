//
//  кщефеуЕуые.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 13.05.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct rotateTest: View {
//    @State var
    @State var newX: CGFloat = 0
    @State var newY: CGFloat = 0
    @State var center: CGPoint = CGPoint(x: 175, y: 320)
    @State var dot: CGPoint = CGPoint(x: 330, y: 320)
    @State var newDot: CGPoint = CGPoint(x: 0, y: 0)
    @State var newRotate: Angle = .zero
    @State var supDegree: Double = .zero
    var body: some View {
        
        ZStack{
            Image("radimg")
                .resizable()
                .scaledToFit()
            Text("\(newRotate.degrees) \(newRotate.radians) x: \(newDot.x + dot.x) y: \(newDot.y + dot.y)")
                .offset(x: 0, y: -200)
            Rectangle()
                .overlay(
                    Circle()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .frame(width: 20, height: 20)
                        .offset(x: 100, y: 0)
                )
                .frame(width: 300, height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(newRotate)
                .position(center)
                
            
            Circle()
                .frame(width: 30, height: 30)
                .position(dot)
                .offset(x: newDot.x, y: newDot.y)
                //                   .position(x: newX)
                .gesture(DragGesture()
                            .onChanged{ value in
                                let dotVelocity = CGPoint(x: value.translation.width + dot.x, y: value.translation.height + dot.y)
                                let degrees = Angle(degrees: Double(
                                    atan2(center.y - dotVelocity.y, center.x - dotVelocity.x) -
                                    atan2(dotVelocity.y - dot.y, dotVelocity.x - dot.x)
                                                                        
                                ))
                                
                                var supposedDegree = Double(degrees.degrees )
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
