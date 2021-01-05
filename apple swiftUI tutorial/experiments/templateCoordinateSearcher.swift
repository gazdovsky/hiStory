//
//  templateCoordinateSearcher.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 03.06.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct templateCoordinateSearcher: View {
    @State var w: CGFloat = 200
    @State var h: CGFloat = 50
    @State var angle: Double  = 0
    @State var inputAngle = "ee"
    @State private var currentPosition: CGSize = .zero
    @State private var     newPosition: CGSize = .zero
    
    var body: some View {
        
       ZStack{
           
        VStack{
            Text("w:\(Int(self.w)) h:\(Int(self.h)) a:\(Int(self.angle))")
            HStack{
                Slider(value: self.$angle, in: -30...30, step: 1)
                Text("\(Int(self.angle))")
            }
            HStack{
                Slider(value: self.$h, in: 30...300, step: 1)
                Text("\(Int(self.h))")
            }
            HStack{
                Slider(value: self.$w, in: 30...300, step: 1)
                Text("\(Int(self.w))")
            }
            Text("\(Int(self.w))")
        }
        Rectangle()
            .opacity(0.0)
            .border( Color.red,width: 2)
//            .addComandButton()
            .frame(width: self.w, height: self.h)
            .rotationEffect(Angle(degrees: self.angle))
            .overlay(
//                667/2- 375/2-
                Text("\(Int(currentPosition.width + 375/2)) \(Int(currentPosition.height + 667/2))")
            )
        .offset(self.currentPosition)
        .gesture(DragGesture(minimumDistance: 5)
            .onChanged({value in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width,
                                              height: value.translation.height + self.newPosition.height)
            })
            .onEnded({ value in
                self.newPosition = self.currentPosition
            }))

       }
        .frame(width: 250, height: 100)
    }
}

struct templateCoordinateSearcher_Previews: PreviewProvider {
    static var previews: some View {
        templateCoordinateSearcher()
    }
}
