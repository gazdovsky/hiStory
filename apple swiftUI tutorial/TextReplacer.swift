//
//  TextReplacer.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 15.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct TextReplacer: View {
    @State var test = "testtext"
    @State var text1x = 90
    var body: some View {
         
        ZStack{
             Image("turtlerock")
                .padding()
//                .position(x:)
            Image("turtlerock-1")
                .padding()
            .position(.init(x: 200, y: 200))
            TextField("text",text: $test)
        }
        
            
    }
}
class PHImageManager : NSObject {
    
}

struct TextReplacer_Previews: PreviewProvider {
    static var previews: some View {
        TextReplacer()
    }
}
