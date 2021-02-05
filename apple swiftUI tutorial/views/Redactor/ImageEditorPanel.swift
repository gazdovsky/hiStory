//
//  ImageEditorPanel.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct ImageEditorPanel: View {
//    @ObservedObject var settings: selectorContainerStore = .shared
//    @ObservedObject var data: photoContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    let iconSize: CGFloat = 25
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            Spacer()
            ToolbarButton(icon: "xmark", isSelected: true, size: iconSize){
                let activeContainer = redactor.photoContainers.indexOfActiveContainer()
                redactor.photoContainers.clearContainer(index: activeContainer)
                redactor.redactorMode = .nothing
                redactor.photoContainers.deleteContainerImageFromFolder(index: activeContainer)
                redactor.photoContainers.containers[activeContainer] = photoSelector()
                redactor.photoContainers.saveTransformToFolder()
//                redactor.saveDraftPreview()
            }
            .padding([.leading,.trailing])
            ToolbarButton(icon: "checkmark", isSelected: true, size: iconSize){
                redactor.photoContainers.acceptContainerChanges(index: redactor.photoContainers.indexOfActiveContainer())
                redactor.photoContainers.saveTransformToFolder()
                redactor.redactorMode = .nothing
            }
            .padding([.leading,.trailing])
            Spacer()
        }
        
        )
        .padding([.top,.bottom],10)
        .background(Color(hex:"a98162")
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
        )
        
    }
}

struct ImageEditorPanel_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            
            Color(.systemGreen)
            ImageEditorPanel()
        }
    }
}
