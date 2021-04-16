//
//  dataFetchTest.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 02.06.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI



struct dataFetchTest: View {
    @State var screenWidth:CGFloat = UIScreen.main.bounds.width
    @State var screenHeigth:CGFloat = UIScreen.main.bounds.height
    var baseRatio:CGFloat = 1920/1080
    var scl:CGFloat = 667/1920
    let imgCont:[container] = readPlst("imgContainer.json")
    var scale:CGFloat = 0.2
    var body: some View {
        ZStack{
            Image(StoryPreviews[5].name)
                .opacity(0.2)
//                .scaleEffect(self.scl)
          
            ForEach(0..<imgCont.count){n in
                SwiftUIPhotoSelector(
//                    x: (self.imgCont[n].x ),
//                    y: (self.imgCont[n].y ),
//                    h: self.imgCont[n].h ,
//                    w: self.imgCont[n].w
//                    angle: self.imgCont[n].angle
                )
                    .position(x: self.imgCont[n].x, y: self.imgCont[n].y)
//                    .rotationEffect(Angle(degrees: self.imgCont[n].angle))
                Text("\(self.screenWidth) \(self.screenHeigth)")
//                Rectangle()
//                .frame(width: self.imgCont[n].w, height: self.imgCont[n].h )
//                .position(x: self.imgCont[n].x, y: self.imgCont[n].y)
//                .rotationEffect(Angle(degrees: self.imgCont[n].angle))
//                    .foregroundColor(.red)
//                    .opacity(0.2)
                    
                    
            }
//            .scaleEffect(0.29)
        }
    }
}

struct dataFetchTest_Previews: PreviewProvider {
    static var previews: some View {
        dataFetchTest()
//            .scaleEffect(0.2)
    }
}
