//
//  framesImgBounds.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 23.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct framesImgBounds: View {
  @State var rotate1: Double = 0
//    var rect =  imgContainer(height: 40, width: 50, rotate: 30)
    var body: some View {
        ZStack{
//            List(content: )
            imgContainer(x:100,y:300,height: 40, width: 50, rotate: self.rotate1)
            imgContainer(x:140,y:300,height: 50, width: 50, rotate: self.rotate1*0.6)
            imgContainer(x:180,y:300,height: 50, width: 50, rotate: self.rotate1*2)
            Slider(value: self.$rotate1, in: 0...360)
            .padding()
            .offset(CGSize(width: 0, height: 40))
        }
    }
}
struct imgContainer: View {
    let x:CGFloat
    let y:CGFloat
    let height:CGFloat
    let width :CGFloat
    let rotate: Double
    var body: some View{
        Rectangle()
            .fill(Color( red: 1.0, green: 50.0, blue: 6.0))
            .border(Color( red: 0.0, green: 0.0, blue: 100.0), width: 2.0)
            .frame(width: self.width, height: self.height)
            .padding(4)
//            .strokedDashAnimated()
            .rotationEffect(Angle(degrees: self.rotate))
            .position(x: self.x, y: self.y)
            .draggable()
        
    }
}



struct framesImgBounds_Previews: PreviewProvider {
    static var previews: some View {
        framesImgBounds()
    }
}
