//
//  frame.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 23.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct frame1: View {
    @ObservedObject var settings: selectorContainer = .shared
//    @ObservedObject var textFields: textContainersFrameData = .shared
    let imgW = CGFloat(1080)
    @State var showButton: Bool = false
    @State var activateSomeRedactor: Bool = false
    @State var activateCurrentRedactor: Bool = false
    @State var containerCounter: Int = 0
    @State var activeContainerid:String = ""
    @State var restoreFromDrafts: Bool = false
    @State var size: CGFloat = 0.1
    let screenW = UIScreen.main.bounds.width
    var body: some View {
//        ZStack{
            Image(settings.templateImageName)
                .resizable()
                .aspectRatio(1080/1920, contentMode: .fit)
                .background(
                    Color(hex: "bbbbbb")
                )
                .opacity(settings.templateOpacity ? 0 : 0) 
                .overlay(
                    photoContainersFrame(templateWidth: screenW / CGFloat(templateWidthDivider))
                )
                .overlay(
                    textContainersFrame(templateWidth: screenW / CGFloat(templateWidthDivider))
                )
//                .onAppear {
//                    print("frame", screenW / CGFloat(templateWidthDivider) )
//                }
//        }
      
    }
}

struct frame_Previews: PreviewProvider {
    static var previews: some View {
        frame1()
            .previewDevice("iPhone X")
    }
}


