//
//  MakeDraggable.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 27.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct DraggableView: View {
    @State var moveAlong = false
    var body: some View {
        ZStack{
            
            Rectangle()
                .frame(width: 150, height: 150)
                .opacity(0.2)
                .overlay(
                    GeometryReader{bigG in
                        Rectangle()
                            .overlay(
                                GeometryReader{g in
                                    Rectangle()
                                    //                                        .frame(width: bigG.frame(in: .global).minX, height: g.frame(in: .global).maxX)
                                    //                                        .foregroundColor(Color.green)
                                    
                                    
                                }
                        )
                        //                    .draggable()
                    }.coordinateSpace(name: "big")
            )
            
        }
    }
}


struct MakeDraggable: ViewModifier{
    
    @State private var currentPosition: CGSize = .zero
    @State private var     newPosition: CGSize = .zero
    var callback:()->() = {print("r")}
    func body(content: Content) -> some View {
        content
            .offset(self.currentPosition)
            .gesture(DragGesture(minimumDistance: 5)
                .onChanged({value in
                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width,
                                                  height: value.translation.height + self.newPosition.height)
                    self.callback()
                })
                .onEnded({ value in
                    self.newPosition = self.currentPosition
                }))
    }
}

extension View{
    func draggable(callback: @escaping ()->() = {}) -> some View{
        self.modifier(MakeDraggable(callback: callback))
    }
}



struct MakeDraggable_Previews: PreviewProvider {
    static var previews: some View {
        DraggableView()
    }
}
