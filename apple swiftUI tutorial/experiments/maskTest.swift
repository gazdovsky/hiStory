//
//  maskTest.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 10.03.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI


struct maskView: View {
    var body: some View {
        ZStack{
        Rectangle()
            .frame(width: 200, height: 300)
            .foregroundColor(.white)
//            .mask(
                Image( "color addict 4")
                    .resizable()
                    .scaledToFill()
                   
//                .compositingGroup()
//
//                    .colorInvert()
                    
//            )
}
        
    }
}

struct maskTest: View {
    var body: some View {
        Rectangle()
            .frame(width: 200, height: 300)
            .foregroundColor(.red)
            .mask(
                maskView()
                    .compositingGroup()
                    .luminanceToAlpha() 
            )

    }
}

struct maskTest_Previews: PreviewProvider {
    static var previews: some View {
        maskTest()
    }
}
