//
//  resisableText.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 03.06.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct makeTransformingImage: ViewModifier{
    @ObservedObject var settings: selectorContainerStore = .shared
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
    
    
    func body(content: Content) -> some View{
        
        
        let mGesture =  MagnificationGesture(minimumScaleDelta: 0.1)
            .onChanged({scaleValue in
                if !transforming {return}
                if self.needSynchronizeMagnification {
                    self.newScale = self.settings.containers[index].transform.currentScale
                    self.needSynchronizeMagnification = false
                }
                self.settings.containers[index].transform.currentScale = self.newScale * scaleValue
            })
            .onEnded({_ in
                if !transforming {return}
                self.newScale = self.settings.containers[index].transform.currentScale
            })
        
        let dGesture = DragGesture(minimumDistance: 5)
            .onChanged({value in
                if !transforming {return}
                
                if self.needSynchronizeDrag &&
                    abs(self.settings.containers[index].transform.currentPosition.width - value.translation.width) > 5 &&
                    abs(self.settings.containers[index].transform.currentPosition.height - value.translation.height) > 5 &&
                    self.settings.containers[index].transform.currentPosition.width > 5
                {
                    self.newPosition = self.settings.containers[index].transform.currentPosition
                    self.needSynchronizeDrag = false
                }
                self.settings.containers[index].transform.currentPosition = CGSize(
                    width: value.translation.width + self.newPosition.width,
                    height: value.translation.height + self.newPosition.height)
            })
            .onEnded({ value in
                if !transforming {return}
                self.newPosition = self.settings.containers[index].transform.currentPosition
            })
        
        let rGesture = RotationGesture()
            .onChanged({degrees in
                if !transforming {return}
                if self.needSynchronizeAngle {
                    self.newrotate = self.settings.containers[index].transform.rotate
                    self.needSynchronizeAngle = false
                }
                self.settings.containers[index].transform.rotate = self.newrotate + Double(degrees.degrees / 180 * .pi)
            })
            .onEnded({ degrees in
                self.newrotate = self.settings.containers[index].transform.rotate
            })
        
        let multiGesture = dGesture.simultaneously(with: mGesture).simultaneously(with: rGesture)
        //        self.settings.saveTransformToFolder()
        return content
            .scaleEffect(self.settings.containers[index].transform.currentScale)
            .rotationEffect(Angle(degrees: self.settings.containers[index].transform.rotate * 180 / .pi) )
            .offset(self.settings.containers[index].transform.currentPosition)
            .gesture(multiGesture)
//            .overlay(
//                ZStack{
//
//                    VStack{Text("w:\(Int(self.settings.containers[index].transform.currentPosition.width)) h:\(Int(self.settings.containers[index].transform.currentPosition.height))")
//                        Text("x:\(Int(UnitPoint.center.x)) y:\(Int(UnitPoint.center.y))")
//
//
//                    }
//                }
//            )
    }
}



//struct transformingTextImage_Previews: PreviewProvider {
//    static var previews: some View {
//        transformingImageTest()
//    }
//}
