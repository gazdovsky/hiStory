//
//  dashedLine.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 27.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct dashedLine: View {
    var body: some View {
        VStack {
//            Path{ path in
//                path.move(to: CGPoint(x: 20, y: 300))
//                path.addLine(to: CGPoint(x: 200, y: 300))
//            }
            Rectangle()
                .size(CGSize(width: 0, height: 1000))
                .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                .stroke(style: StrokeStyle( lineWidth: 1, dash: [3]))
                .foregroundColor(Color(UIColor.blue))
        }
    }
}

struct dashedLine_Previews: PreviewProvider {
    static var previews: some View {
        dashedLine()
    }
}
