//
//  ViewStackTest.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 28.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct ViewStackTest: View {
    var body: some View {
        ZStack{
            VStack{
                z()
                z()
            }
       
            
        }
        
        
    }
}


struct v: View {
    var body: some View{
        VStack{
            Rectangle()
                .foregroundColor(Color.green)
                .border(Color.blue, width: 10)
        }
    }
}
struct z: View {
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(Color.green)
                .border(Color.blue, width: 10)
        }
    }
}

struct ViewStackTest_Previews: PreviewProvider {
    static var previews: some View {
        ViewStackTest()
    }
}
