//
//  geometryReaderTest.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 12.04.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct geometryReaderTest: View {
    var body: some View {
        ZStack(alignment: .top) {
            VStack{
                ZStack(alignment: .top) {
                    Image("color addict 1")
                        .resizable()
                        .aspectRatio(1080/1920, contentMode: .fit)
                        
                        .aspectRatio(contentMode: .fit)
                        .overlay(
                            Image("color addict 1")
                                .resizable()
//                                .aspectRatio(1080/1920, contentMode: .fit)
                                .overlay(
                                    GeometryReader{g in
                                        Text("\(g.size.width)")
                                    }
                                )
                        )
                }
            }
        }
     
    }
}

struct geometryReaderTest_Previews: PreviewProvider {
    static var previews: some View {
        geometryReaderTest()
    }
}
