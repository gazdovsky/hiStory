//
//  Expandable rect.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 05.06.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct Expandable_rect: View {
    @State var x1: CGFloat=0
    @State var w: CGFloat = 100
    @State var h: CGFloat = 100
    
    @State var c1t: CGFloat = 0
    @State var c2t: CGFloat = 0
    //    @State var p1:
    var body: some View {
        ZStack{
            VStack{
                Text("c1t: \(c1t)")
                Text("c2t: \(c2t)")
                Text("w: \(w)")
            HStack{
                Circle()
                    .offset(CGSize(width: c1t, height: 0))
                    .frame(width: 20, height: 20)
                    .gesture(DragGesture()
                                .onChanged({
                                    value in
                                    c1t =  value.translation.width
                                    w += -c1t
                     })
                             )
                Rectangle()
                    .frame(width: w, height: h)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Circle()
                    .offset(CGSize(width: c2t, height: 0))
                    .frame(width: 20, height: 20)
                    .gesture(DragGesture()
                                .onChanged({
                                    value in
                                    c2t =  value.translation.width
                                    w +=   c2t
                    })
                             )
            }
            .rotationEffect(Angle(degrees: 30))
            }
        }
    }
}



struct Expandable_rect_Previews: PreviewProvider {
    static var previews: some View {
        Expandable_rect()
    }
}
