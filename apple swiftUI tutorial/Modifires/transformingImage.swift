//
//  resisableText.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 03.06.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct makeTransformingImage: ViewModifier{
//    @ObservedObject var settings: selectorContainerStore = .shared
    @ObservedObject var data: photoContainersFrameData = .shared
    @State var index: Int
    @State private var currentScale:   CGFloat = 1.0
    @State private var     newScale:   CGFloat = 1.0
    @State         var          rotate: Double = 0.0
    @State         var       newrotate: Double = 0.0
    @State private var currentPosition: CGSize = .zero
    @State private var     newPosition: CGSize = .zero
    @State var needSynchronizeMagnification: Bool = true
    @State var needSynchronizeDrag: Bool = true
    @State var needSynchronizeAngle: Bool = true
    @Binding var transforming: Bool
    @State var increaser: CGFloat
    @GestureState var isScale: Bool = false
    @GestureState var isDrag: Bool = false
    @GestureState var isRotate: Bool = false
    @State var updateGesture: Bool = false
    var centerizeDelta: CGFloat = 10
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func body(content: Content) -> some View{
        
        
//        let mGesture =  MagnificationGesture(minimumScaleDelta: 0.1)
//            .updating( $isScale, body: { currentState, gestureState, transaction in
//                gestureState = true
//            })
//            .onChanged({scaleValue in
//                if !transforming {return}
//                if  needSynchronizeMagnification {
//                     newScale =  data.containers[index].transform.currentScale
//                     needSynchronizeMagnification = false
//                }
//                data.containers[index].transform.currentScale =  newScale * scaleValue
//            })
//            .onEnded({_ in
//                if !transforming {return}
//                 newScale =  data.containers[index].transform.currentScale
//            })
        
        let dGesture = DragGesture(minimumDistance: 5)
            .updating( $isDrag, body: { currentState, gestureState, transaction in
                gestureState = true
            })
            .onChanged({value in
                if !transforming {return}
                
                if  needSynchronizeDrag &&
                    abs(data.containers[index].transform.currentPosition.width - value.translation.width) > 5 &&
                    abs(data.containers[index].transform.currentPosition.height - value.translation.height) > 5 &&
                        data.containers[index].transform.currentPosition.width > 5
                {
                     newPosition =  data.containers[index].transform.currentPosition
                     needSynchronizeDrag = false
                }
                let supposedWidth = value.translation.width + newPosition.width
                let supposedHeight = value.translation.height + newPosition.height
                let centerX = CGFloat(0.0)//(increaser * 1080) / 2 + (data.containers[index].imageInBlackBox.size.width * increaser) / 2
                let centerY = CGFloat(0.0)//(increaser * 1920) / 2
                
                data.containers[index].transform.currentPosition = CGSize(
                    width: centerX - centerizeDelta...centerX + centerizeDelta ~= supposedWidth ? centerX : supposedWidth,
                    height: centerY - centerizeDelta...centerY + centerizeDelta ~= supposedHeight ? centerY : supposedHeight
                )
            })
            .onEnded({ value in
                if !transforming {return}
                 newPosition = data.containers[index].transform.currentPosition
            })
        
//        let rGesture = RotationGesture(minimumAngleDelta: Angle(degrees: 5))
//            .updating( $isRotate, body: { currentState, gestureState, transaction in
//                gestureState = true
//            })
//            .onChanged({degrees in
//                if !transforming {return}
//                if  needSynchronizeAngle {
//                     newrotate =  data.containers[index].transform.rotate
//                     needSynchronizeAngle = false
//                }
//                
//                var supposedDegree = newrotate + Double(degrees.degrees / 180 * .pi)
//                if supposedDegree > Double.pi * 2 {
//                    supposedDegree = supposedDegree - Double.pi * 2
//                } else if supposedDegree < -Double.pi * 2 {
//                        supposedDegree = supposedDegree + Double.pi * 2
//                    }
//                
//                //
//                let deltaDegree = Double(0.1)
//                
//                func newAngle() -> Double {
//                    let fixPointsNumber: Int = 8
//                    var fixPoints: [Double] = []
//                    let fixStep: Double = (2 * Double.pi) / Double(fixPointsNumber)
//                    var aligns: [ClosedRange<Double>] = []
//                    for i in 0..<fixPointsNumber {
//                        fixPoints.append(fixStep * Double(i))
//                        aligns.append(fixPoints[i] - deltaDegree...fixPoints[i] + deltaDegree)
//                        if aligns[i] ~= abs(supposedDegree) {
//                        return fixPoints[i] * (abs(supposedDegree) / supposedDegree)
//                        }
//                    }
//                    return supposedDegree
//                }
//                
////               print(supposedDegree)
//                
//                data.containers[index].transform.rotate = newAngle()
//                
////                data.containers[index].transform.rotate =  newrotate + Double(degrees.degrees / 180 * .pi)
//            })
//            .onEnded({ degrees in
//                 newrotate = data.containers[index].transform.rotate
//            })
        
//        let multiGesture = dGesture.simultaneously(with: mGesture).simultaneously(with: rGesture)
//        let multiGesture = dGesture.simultaneously(with: mGesture)
//        let multiGesture = dGesture.simultaneously(with: rGesture)
//        let multiGesture = dGesture
//        let multiGesture = dGesture.sequenced(before: mGesture)
//        let multiGesture = mGesture
//        print(isScale, isRotate, isDrag)
        return content
            .scaleEffect(data.containers[index].transform.currentScale)
            .rotationEffect(Angle(degrees: data.containers[index].transform.rotate * 180 / .pi))
            .offset(offset)
//            .gesture(transforming ? multiGesture : nil)
//            .onReceive(timer) { input in
//                if isScale == false && isRotate == false && isDrag == false {
//                    transforming = false
//                    transforming = true
////                    updateGesture
////                    transforming.toggle()
//                }
//                        }
    }
    var offset: CGSize {
        if increaser == 1 || increaser < 0.1 {
            return CGSize(width: data.containers[index].transform.currentPosition.width * data.increaser, height: data.containers[index].transform.currentPosition.height * data.increaser)
        } else {
            return data.containers[index].transform.currentPosition
        }
    }
}



//struct transformingTextImage_Previews: PreviewProvider {
//    static var previews: some View {
//        transformingImageTest()
//    }
//}
