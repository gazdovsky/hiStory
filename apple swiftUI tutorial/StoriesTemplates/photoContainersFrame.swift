//
//  photoContainersFrame.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 05.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

class photoContainersFrameData: ObservableObject{
    init() {
    }
    static var shared = photoContainersFrameData()
    @ObservedObject var storyTemplate: selectorContainerStore = .shared
    
    @Published var containers:Array<photoSelector> = Array(repeating:  photoSelector() , count: 5)
}

struct photoContainersFrame: View {
    @ObservedObject var data: photoContainersFrameData = .shared
    let imgW = CGFloat(1080)
    var tmp: [storyTemplate] {
        readPlst(data.storyTemplate.templateName)
    }
    var crnts: [container] {
        tmp[0].containers ?? readPlst("defaultContainer.json")
    }
    var body: some View {
        Image(data.storyTemplate.templateImageName)
            .resizable()
            .aspectRatio(1080/1920, contentMode: .fit)
            .overlay(
                GeometryReader{ g in
                    ZStack{
                        Rectangle()
                            .resisable()
                            .shadow(radius: 20)
                            
                            .foregroundColor(Color.white)
                            .opacity(0.3)
                            
                        ForEach(crnts.indices){ index -> AnyView in
                            if(crnts.count <= index ){
                                return AnyView(EmptyView())
                            }
                            let i = crnts[index]
                            if(i.id == "empty" ){
                                return AnyView(EmptyView())
                            }
                            
                            return AnyView  (
                                photoSelectorWithParams(
                                    actualTemplateWith: g.size.width,
                                    actualTemplateHeight: g.size.height,
                                    konstantTemplateWith: imgW,
                                    container: i,
                                    redactorActive: $data.containers[index].redactorActive,
                                    templateOpacity: $data.storyTemplate.templateOpacity,
                                    index: index)
                                    .onTapGesture {
                                        var activeCount = 0
                                        for indexActive in 0...crnts.count{
                                            if indexActive != index {
                                                data.containers[indexActive].redactorActive = false
                                            }
                                            if data.containers[indexActive].redactorActive == true {activeCount += 1}
                                        }
                                        data.containers[index].redactorActive.toggle()
                                        data.storyTemplate.templateOpacity = activeCount == 0 ? true : false
                                        if data.containers[index].redactorActive {
                                            data.storyTemplate.redactorMode = .imageEdit
                                        } else {
                                            data.storyTemplate.redactorMode = .nothing
                                        }
                                    }
                                    .disabled(!data.containers[index].redactorActive && data.storyTemplate.templateOpacity)
                                    .zIndex(!data.containers[index].redactorActive && data.storyTemplate.templateOpacity ? 0 : 2)
                            )
                        }
                        Image(data.storyTemplate.templateImageName)
                             .resizable()
                             .zIndex(3)
                             .aspectRatio(1080/1920, contentMode: .fit)
                             .contentShape(
                                 Rectangle()
                                     .size(CGSize(width: 1.0, height: 1.0))
                             )
                            .opacity(data.storyTemplate.templateOpacity ? 0.5 : 1)
                    }
                    .onAppear(perform: {
//                            tGeom = g.frame(in: .global)
                    }
                    )
                }
            )
    }
}

struct photoContainersFrame_Previews: PreviewProvider {
    static var previews: some View {
        photoContainersFrame()
    }
}
