//
//  frame.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 23.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct frame1: View {
    @ObservedObject var settings: selectorContainerStore = .shared
//    var tmp: [storyTemplate] {
//        readPlst(settings.templateName)
//    }
//    var crnts: [container] {
//        tmp[0].containers ?? readPlst("defaultContainer.json")
//    }
    let imgW = CGFloat(1080)
    @State var showButton: Bool = false
    @State var activateSomeRedactor: Bool = false
    @State var activateCurrentRedactor: Bool = false
    @State var containerCounter: Int = 0
    @State var activeContainerid:String = ""
    @State var restoreFromDrafts: Bool = false
//    @State var storyImage: UIImage = UIImage()
//    @State var tGeom: CGRect = CGRect()
    @State var size: CGFloat = 0.1
    var repeatingAnimation: Animation {
            Animation
                .linear(duration: 2)
                .repeatForever()
        }
    var body: some View {
        ZStack{
            Image(settings.templateImageName)
                .resizable()
                .aspectRatio(1080/1920, contentMode: .fit)
                .background(
                    Color(hex: "#bbbbbb")
                )
                .opacity(settings.templateOpacity ? 0 : 0) 
                .overlay(
//                    GeometryReader{ g in
//                        ZStack{
//                            Rectangle()
//                                .resisable()
//                                .shadow(radius: 20)
//                                
//                                .foregroundColor(Color.white)
//                                .opacity(0.3)
//                                
//                            ForEach(self.crnts.indices){ index -> AnyView in
//                                if(self.crnts.count <= index ){
//                                    return AnyView(EmptyView())
//                                }
//                                let i = self.crnts[index]
//                                if(i.id == "empty" ){
//                                    return AnyView(EmptyView())
//                                }
//                                
//                                return AnyView  (
//                                    photoSelectorWithParams(
//                                        actualTemplateWith: g.size.width,
//                                        actualTemplateHeight: g.size.height,
//                                        konstantTemplateWith: self.imgW,
//                                        container: i,
//                                        redactorActive: self.$settings.containers[index].redactorActive,
//                                        templateOpacity: $settings.templateOpacity,
//                                        index: index)
//                                        .onTapGesture {
//                                            var activeCount = 0
//                                            for indexActive in 0...self.crnts.count{
//                                                if indexActive != index {
//                                                    self.settings.containers[indexActive].redactorActive = false
//                                                }
//                                                if self.settings.containers[indexActive].redactorActive == true {activeCount += 1}
//                                            }
//                                            self.settings.containers[index].redactorActive.toggle()
//                                            settings.templateOpacity = activeCount == 0 ? true : false
//                                            if self.settings.containers[index].redactorActive {
//                                                self.settings.redactorMode = .imageEdit
//                                            } else {
//                                                self.settings.redactorMode = .nothing
//                                            }
//                                        }
//                                        .disabled(!settings.containers[index].redactorActive && settings.templateOpacity)
//                                        .zIndex(!settings.containers[index].redactorActive && settings.templateOpacity ? 0 : 2)
//                                )
//                            }
//                             Image(settings.templateImageName)
//                                 .resizable()
//                                 .zIndex(3)
//                                 .aspectRatio(1080/1920, contentMode: .fit)
//                                 .contentShape(
//                                     Rectangle()
//                                         .size(CGSize(width: 1.0, height: 1.0))
//                                 )
//                                .opacity(settings.templateOpacity ? 0.5 : 1)
//                        }
//                        .onAppear(perform: {
////                            tGeom = g.frame(in: .global)
//                        }
//                        )
//                    }
                    photoContainersFrame()
                )
                .overlay(
//                    ZStack{
//                        ForEach(settings.textContainers.indices){ u in
//                            textViewWrapper(textViewItem: $settings.textContainers[u], index: u)
//                                .modifier(makeTransformingMultilineText(index : u, fontSize: settings.textContainers[u].fontSize))
//                        }
//                    }
                    textContainersFrame()
                )
                
            
            Image(settings.templateImageName)
                .resizable()
                .aspectRatio(1080/1920, contentMode: .fit)
                .background(
                    Color(hex: "#bbbbbb")
                )
                .opacity(0)
//            Text("\(tGeom.debugDescription)")
        }
        
    }
}

struct frame_Previews: PreviewProvider {
    static var previews: some View {
        frame1()
            .previewDevice("iPhone X")
    }
}


